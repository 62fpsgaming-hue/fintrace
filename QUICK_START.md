# Quick Start - Enhanced Dashboard

## 🚀 Get Started in 3 Steps

### Step 1: Start the Server
```bash
cd dashboard
npm run dev
```

### Step 2: Open Dashboard
Navigate to: http://localhost:3000/dashboard

### Step 3: Upload CSV
Upload `backend/test_transactions.csv` or your own transaction data

---

## ✨ Try These Features

### 1. View Network Health (Top of Page)
Look for the card showing:
- Network Risk Level: High/Elevated/Normal
- Suspicious Rate percentage
- Ring Density percentage
- Overall Risk Score

### 2. Isolate a Fraud Ring
1. Scroll to the graph
2. Click any "Ring X" button
3. Watch the graph focus on that ring
4. See metrics panel appear on the right

### 3. Filter by Anomaly Type
1. Find the "Anomaly Type" dropdown
2. Select "Velocity Spike" or "Structuring"
3. Graph updates to show only matching accounts

### 4. Hover Over Edges
1. Move mouse over any line between nodes
2. See tooltip with:
   - Total amount transferred
   - Number of transactions
   - Last transaction time

### 5. View Risk Breakdown
1. Click any red (suspicious) node
2. Right panel opens
3. Scroll to "Risk Breakdown"
4. See 5 factors contributing to risk score

---

## 📊 What You'll See

### Enhanced Summary Cards
- Trend indicators (↑ ↓ →)
- Industry benchmarks
- Performance metrics
- Context explanations

### Enhanced Graph
- Thick edges = large amounts
- Opaque edges = frequent transactions
- Orange edges = large flows (>$10k)
- Ring isolation buttons
- Temporal controls
- Anomaly filters

### Enhanced Node Details
- Risk decomposition (5 factors)
- Audit trail
- Compliance notes
- Actionable recommendations

---

## 🎯 Key Shortcuts

| Action | How To |
|--------|--------|
| Isolate ring | Click "Ring X" button |
| Clear filters | Click reset icon |
| Zoom in/out | Use zoom buttons or scroll |
| Fit to view | Click maximize button |
| Show amounts | Toggle "Show Amounts" |
| Filter anomalies | Use dropdown menu |

---

## 📖 Documentation

- `INTEGRATION_COMPLETE.md` - Integration details
- `DASHBOARD_ENHANCEMENTS_COMPLETE.md` - Feature documentation
- `VISUAL_CHANGES_GUIDE.md` - Before/after comparison
- `USER_MANAGEMENT_GUIDE.md` - User system guide

---

## 🐛 Troubleshooting

**Graph not showing?**
- Check browser console for errors
- Verify CSV uploaded successfully
- Try refreshing the page

**Metrics panel not appearing?**
- Make sure you clicked a ring isolation button
- Check that the ring has members

**Filters not working?**
- Clear all filters and try again
- Verify data has the pattern you're filtering for

---

## 💡 Pro Tips

1. **Use ring isolation** for focused investigation
2. **Combine filters** for precise analysis
3. **Hover edges** to understand transaction flows
4. **Check risk breakdown** for audit explanations
5. **Compare to benchmarks** for context

---

## ✅ Success!

You're now using the enhanced RIFT fraud detection dashboard with:
- Advanced edge intelligence
- Ring isolation and metrics
- Risk decomposition
- Contextual benchmarks
- Professional-grade visualization

Happy fraud hunting! 🕵️‍♂️
