# Testing Guide - Money Muling Detection System

## Quick Start Testing

### 1. Backend API Test

```bash
# Start the backend
cd backend
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# In another terminal, test the API
curl -X POST http://localhost:8000/analyze \
  -F "file=@test_transactions.csv" \
  -o response.json

# Validate the output format
python validate_output.py response.json
```

Expected output:
```
✅ VALIDATION PASSED
   - 10 suspicious accounts
   - 2 fraud rings
   - 10 total accounts
```

### 2. Frontend Integration Test

```bash
# Terminal 1: Start backend
cd backend
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Terminal 2: Start frontend
cd dashboard
pnpm install  # if not already done
pnpm dev
```

Open browser to `http://localhost:3000` and:
1. Navigate to "Analyze" tab
2. Upload `backend/test_transactions.csv`
3. Click "Analyze Transactions"
4. Verify results appear

### 3. Output Format Validation

The system must produce output matching this EXACT format:

```json
{
  "suspicious_accounts": [
    {
      "account_id": "ACC_A",
      "suspicion_score": 87.5,
      "detected_patterns": ["cycle_length_3", "high_velocity"],
      "ring_id": "RING_001"
    }
  ],
  "fraud_rings": [
    {
      "ring_id": "RING_001",
      "member_accounts": ["ACC_A", "ACC_B", "ACC_C"],
      "pattern_type": "cycle",
      "risk_score": 95.3,
      "member_count": 3
    }
  ],
  "summary": {
    "total_accounts_analyzed": 500,
    "suspicious_accounts_flagged": 15,
    "fraud_rings_detected": 4,
    "processing_time_seconds": 2.3
  }
}
```

---

## Test Cases

### Test Case 1: Cycle Detection (3-node ring)

**Input CSV**:
```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX001,ACC_A,ACC_B,500.00,2025-01-01 09:00:00
TX002,ACC_B,ACC_C,490.00,2025-01-01 10:00:00
TX003,ACC_C,ACC_A,480.00,2025-01-01 11:00:00
```

**Expected Output**:
- 3 suspicious accounts (ACC_A, ACC_B, ACC_C)
- 1 fraud ring (RING_001)
- Pattern type: "cycle"
- All accounts have pattern: "cycle_length_3"
- Ring members: ["ACC_A", "ACC_B", "ACC_C"]

### Test Case 2: Cycle Detection (5-node ring)

**Input CSV**:
```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX006,ACC_F,ACC_G,200.00,2025-01-03 09:00:00
TX007,ACC_G,ACC_H,195.00,2025-01-03 09:15:00
TX008,ACC_H,ACC_I,190.00,2025-01-03 09:30:00
TX009,ACC_I,ACC_J,185.00,2025-01-03 09:45:00
TX010,ACC_J,ACC_F,180.00,2025-01-03 10:00:00
```

**Expected Output**:
- 5 suspicious accounts
- 1 fraud ring
- Pattern type: "cycle"
- All accounts have pattern: "cycle_length_5"

### Test Case 3: Smurfing (Fan-in)

**Input CSV**: 10+ accounts sending to one receiver within 72 hours

```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX001,ACC_S1,ACC_AGG,100.00,2025-01-01 09:00:00
TX002,ACC_S2,ACC_AGG,100.00,2025-01-01 09:30:00
TX003,ACC_S3,ACC_AGG,100.00,2025-01-01 10:00:00
TX004,ACC_S4,ACC_AGG,100.00,2025-01-01 10:30:00
TX005,ACC_S5,ACC_AGG,100.00,2025-01-01 11:00:00
TX006,ACC_S6,ACC_AGG,100.00,2025-01-01 11:30:00
TX007,ACC_S7,ACC_AGG,100.00,2025-01-01 12:00:00
TX008,ACC_S8,ACC_AGG,100.00,2025-01-01 12:30:00
TX009,ACC_S9,ACC_AGG,100.00,2025-01-01 13:00:00
TX010,ACC_S10,ACC_AGG,100.00,2025-01-01 13:30:00
```

**Expected Output**:
- 11 suspicious accounts (10 senders + 1 aggregator)
- 1 fraud ring
- Pattern type: "smurfing"
- Aggregator has pattern: "fan_in_smurfing"

### Test Case 4: Layered Shell Network

**Input CSV**: 3+ hop chain through low-degree intermediaries

```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX001,ACC_SOURCE,ACC_SHELL1,1000.00,2025-01-01 09:00:00
TX002,ACC_SHELL1,ACC_SHELL2,950.00,2025-01-01 09:30:00
TX003,ACC_SHELL2,ACC_DEST,900.00,2025-01-01 10:00:00
```

**Expected Output**:
- 4 suspicious accounts
- 1 fraud ring
- Pattern type: "layered_shell"
- All accounts have pattern: "layered_shell_chain"

### Test Case 5: High-Velocity Burst

**Input CSV**: 10+ transactions from one account within 24 hours

```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX001,ACC_BURST,ACC_R1,100.00,2025-01-01 09:00:00
TX002,ACC_BURST,ACC_R2,100.00,2025-01-01 09:30:00
TX003,ACC_BURST,ACC_R3,100.00,2025-01-01 10:00:00
TX004,ACC_BURST,ACC_R4,100.00,2025-01-01 10:30:00
TX005,ACC_BURST,ACC_R5,100.00,2025-01-01 11:00:00
TX006,ACC_BURST,ACC_R6,100.00,2025-01-01 11:30:00
TX007,ACC_BURST,ACC_R7,100.00,2025-01-01 12:00:00
TX008,ACC_BURST,ACC_R8,100.00,2025-01-01 12:30:00
TX009,ACC_BURST,ACC_R9,100.00,2025-01-01 13:00:00
TX010,ACC_BURST,ACC_R10,100.00,2025-01-01 13:30:00
```

**Expected Output**:
- ACC_BURST should have "high_velocity" pattern
- Additional +20 points to suspicion score

### Test Case 6: Legitimate Merchant (False Positive Control)

**Input CSV**: Regular transactions over 30+ days with consistent amounts

```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX001,ACC_CUST1,ACC_MERCHANT,99.99,2025-01-01 09:00:00
TX002,ACC_CUST2,ACC_MERCHANT,99.99,2025-01-02 09:00:00
TX003,ACC_CUST3,ACC_MERCHANT,99.99,2025-01-03 09:00:00
... (30+ days of similar transactions)
```

**Expected Output**:
- ACC_MERCHANT should have "merchant_pattern_fp_reduction" pattern
- Suspicion score reduced by 25 points
- Should NOT be flagged if only merchant pattern detected

---

## Validation Checklist

### JSON Format Validation ✓

- [ ] `suspicious_accounts` is an array
- [ ] Each account has `account_id` (string)
- [ ] Each account has `suspicion_score` (float, 0-100)
- [ ] Each account has `detected_patterns` (array of strings)
- [ ] Each account has `ring_id` (string or null)
- [ ] Accounts sorted by `suspicion_score` descending
- [ ] `fraud_rings` is an array
- [ ] Each ring has `ring_id` (string)
- [ ] Each ring has `member_accounts` (array of strings)
- [ ] Each ring has `pattern_type` (string)
- [ ] Each ring has `risk_score` (float, 0-100)
- [ ] Each ring has `member_count` (integer)
- [ ] `member_count` matches length of `member_accounts`
- [ ] `summary` has `total_accounts_analyzed` (integer)
- [ ] `summary` has `suspicious_accounts_flagged` (integer)
- [ ] `summary` has `fraud_rings_detected` (integer)
- [ ] `summary` has `processing_time_seconds` (float)
- [ ] Summary counts match actual array lengths

### Graph Visualization Validation ✓

- [ ] All accounts appear as nodes
- [ ] All transactions appear as directed edges
- [ ] Suspicious accounts are red
- [ ] Normal accounts are blue
- [ ] Ring members have colored borders
- [ ] Node size scales with suspicion score
- [ ] Hover shows account details
- [ ] Click shows detailed panel
- [ ] Filter by ring works
- [ ] Search by account ID works
- [ ] Zoom controls work
- [ ] Fit to view works

### Fraud Ring Table Validation ✓

- [ ] Table shows all detected rings
- [ ] Ring ID column present
- [ ] Pattern Type column present
- [ ] Member Count column present
- [ ] Risk Score column present
- [ ] Member Accounts column present (comma-separated)
- [ ] Sortable by all columns
- [ ] Click row filters graph
- [ ] Risk score color-coded (red > 80, yellow > 50, green ≤ 50)

### Detection Pattern Validation ✓

- [ ] Cycles of length 3-5 detected
- [ ] Fan-in smurfing detected (10+ senders → 1 receiver in 72h)
- [ ] Fan-out smurfing detected (1 sender → 10+ receivers in 72h)
- [ ] Layered shell chains detected (3+ hops, low-degree intermediaries)
- [ ] High-velocity bursts detected (10+ TX in 24h)
- [ ] Degree centrality anomalies detected (top 5%)
- [ ] Merchant patterns reduce false positives

### Performance Validation ✓

- [ ] 10K transactions process in < 30 seconds
- [ ] No crashes or errors
- [ ] Memory usage reasonable
- [ ] Response time acceptable

---

## Automated Testing

### Run Backend Tests

```bash
cd backend
python -m pytest test_main.py -v
```

### Run Output Validator

```bash
# Test with file
python validate_output.py response.json

# Test with stdin
curl -X POST http://localhost:8000/analyze \
  -F "file=@test_transactions.csv" | \
  python validate_output.py -
```

### Run Integration Test

```bash
cd backend
python test_api.py
```

---

## Performance Benchmarking

### Small Dataset (100 transactions)
```bash
time curl -X POST http://localhost:8000/analyze \
  -F "file=@small_test.csv" -o /dev/null
```

Expected: < 1 second

### Medium Dataset (1,000 transactions)
```bash
time curl -X POST http://localhost:8000/analyze \
  -F "file=@medium_test.csv" -o /dev/null
```

Expected: < 5 seconds

### Large Dataset (10,000 transactions)
```bash
time curl -X POST http://localhost:8000/analyze \
  -F "file=@large_test.csv" -o /dev/null
```

Expected: < 30 seconds

---

## Debugging Tips

### Backend Issues

1. **Check logs**: Backend prints detailed logs to console
2. **Verify CSV format**: Ensure columns match required format
3. **Check timestamps**: Must be parseable datetime strings
4. **Validate amounts**: Must be numeric values

### Frontend Issues

1. **Check browser console**: Look for JavaScript errors
2. **Verify API URL**: Check `.env.local` has correct `NEXT_PUBLIC_API_URL`
3. **Check network tab**: Verify API requests are being sent
4. **Clear cache**: Sometimes helps with stale data

### Graph Visualization Issues

1. **Check node count**: Should match total accounts
2. **Check edge count**: Should match total transactions
3. **Verify vis-network loaded**: Check browser console for errors
4. **Try fit to view**: Sometimes graph is zoomed out

---

## Common Issues & Solutions

### Issue: "Missing required columns"
**Solution**: Ensure CSV has: `transaction_id`, `sender_id`, `receiver_id`, `amount`, `timestamp`

### Issue: "Invalid timestamp format"
**Solution**: Use format `YYYY-MM-DD HH:MM:SS` or other supported formats

### Issue: "No fraud rings detected"
**Solution**: Dataset may not contain fraud patterns. Try test CSV with known patterns.

### Issue: "Graph not rendering"
**Solution**: Check browser console, ensure vis-network is loaded, try refreshing page

### Issue: "Suspicion scores all zero"
**Solution**: No patterns detected. Verify detection thresholds in `config.py`

---

## Test Data Generation

### Generate Cycle Pattern

```python
import csv
from datetime import datetime, timedelta

accounts = ['ACC_A', 'ACC_B', 'ACC_C']
with open('cycle_test.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['transaction_id', 'sender_id', 'receiver_id', 'amount', 'timestamp'])
    
    base_time = datetime(2025, 1, 1, 9, 0, 0)
    for i in range(len(accounts)):
        sender = accounts[i]
        receiver = accounts[(i + 1) % len(accounts)]
        timestamp = base_time + timedelta(hours=i)
        writer.writerow([f'TX{i+1:03d}', sender, receiver, 500 - i*10, timestamp])
```

### Generate Smurfing Pattern

```python
import csv
from datetime import datetime, timedelta

with open('smurfing_test.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['transaction_id', 'sender_id', 'receiver_id', 'amount', 'timestamp'])
    
    base_time = datetime(2025, 1, 1, 9, 0, 0)
    for i in range(15):  # 15 senders
        sender = f'ACC_S{i+1}'
        timestamp = base_time + timedelta(minutes=i*30)
        writer.writerow([f'TX{i+1:03d}', sender, 'ACC_AGG', 100, timestamp])
```

---

## Success Criteria

Your system passes testing if:

1. ✅ All test cases produce correct output format
2. ✅ JSON validation passes for all outputs
3. ✅ Graph visualization shows all nodes and edges correctly
4. ✅ Fraud ring table displays all detected rings
5. ✅ Detection patterns work as expected
6. ✅ Performance meets requirements (< 30s for 10K TX)
7. ✅ False positive control works (merchants not flagged)
8. ✅ No crashes or errors during normal operation

---

## Next Steps

1. Run all test cases
2. Validate output format
3. Test with hidden datasets
4. Prepare demo video
5. Document any edge cases found
6. Tune detection thresholds if needed
