# Fintrace – Graph-Based Financial Forensics Engine

> **Money Muling Detection API**
> A production-ready FastAPI backend that detects financial crime rings using
> graph theory, temporal analysis, and intelligent suspicion scoring.

---

## Table of Contents
1. [Architecture](#architecture)
2. [API Reference](#api-reference)
3. [Algorithm Explanation](#algorithm-explanation)
4. [Complexity Analysis](#complexity-analysis)
5. [Setup & Run](#setup--run)
6. [Docker](#docker)
7. [Example CSV & Response](#example-csv--response)

---

## Architecture

```
backend/
├── main.py                  # FastAPI app factory + CORS + router mount
├── requirements.txt
├── Dockerfile
└── app/
    ├── api/
    │   └── routes.py        # POST /analyze endpoint
    ├── core/
    │   └── config.py        # All tunable constants & thresholds
    ├── models/
    │   └── schemas.py       # Pydantic v2 response schemas
    └── services/
        ├── csv_parser.py    # Upload validation & DataFrame conversion
        ├── graph_builder.py # NetworkX DiGraph construction
        ├── pattern_detector.py  # Cycle / Smurfing / Shell detection
        ├── scoring_engine.py    # Weighted suspicion scoring + FP reduction
        └── json_formatter.py   # Assembles final AnalysisResponse
```

Data flow for a single request:

```
CSV Upload
   │
   ▼
csv_parser.parse_csv()          ← validates columns, types, timestamps
   │ DataFrame
   ▼
graph_builder.build_graph()     ← DiGraph: nodes=accounts, edges=transactions
   │ nx.DiGraph + degree_map
   ▼
pattern_detector.run_all_detectors()
   ├── detect_cycles()          ← Johnson's algorithm, length 3–5
   ├── detect_smurfing()        ← two-pointer sliding window, 72 h
   └── detect_layered_shells()  ← DFS up to 5 hops, low-degree filter
   │ [RawRing, ...]
   ▼
scoring_engine.score_accounts() ← weighted model + FP heuristic
scoring_engine.compute_ring_risk_scores()
   │ score_map, pattern_map, ring_map
   ▼
json_formatter.build_response() ← Pydantic validation → JSON
```

---

## API Reference

### `POST /analyze`

| Property       | Value                              |
|----------------|------------------------------------|
| URL            | `http://localhost:8000/analyze`    |
| Method         | `POST`                             |
| Content-Type   | `multipart/form-data`              |
| Field name     | `file`                             |
| Accepted types | `.csv`, `text/csv`, `text/plain`   |

#### Request (curl)
```bash
curl -X POST http://localhost:8000/analyze \
     -F "file=@transactions.csv"
```

#### Response schema (200 OK)
```json
{
  "suspicious_accounts": [
    {
      "account_id": "ACC_00123",
      "suspicion_score": 87.5,
      "detected_patterns": ["cycle_length_3", "high_velocity"],
      "ring_id": "RING_001"
    }
  ],
  "fraud_rings": [
    {
      "ring_id": "RING_001",
      "member_accounts": ["ACC_00123", "ACC_00456"],
      "pattern_type": "cycle",
      "risk_score": 95.3
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

#### Error (400)
```json
{ "detail": "Missing required columns: ['amount', 'timestamp']" }
```

### `GET /health`
Returns `{"status": "ok"}` – used by load-balancers / Docker health checks.

### `GET /docs`
Interactive Swagger UI playground.

---

## Algorithm Explanation

### 1. Cycle Detection (Circular Fund Routing)
Uses **Johnson's algorithm** (`networkx.simple_cycles`) which runs in
O((V + E)(C + 1)) time where C = number of elementary circuits.

Cycles of length 3–5 are kept.  Each unique cycle becomes a `RING_XXX` with:
- `pattern_type = "cycle"`
- per-account label `"cycle_length_N"`
- base suspicion contribution **+40 points**

### 2. Smurfing Detection (Fan-in / Fan-out)
A **two-pointer sliding window** scans each account's sorted transaction list.
If ≥ 10 unique counterparties appear within any 72-hour window the account is
flagged.

- Fan-in  (receiver side): label `"fan_in_smurfing"`
- Fan-out (sender side):   label `"fan_out_smurfing"`
- Base suspicion contribution: **+30 points**

### 3. Layered Shell Network Detection
A **DFS** from every source node explores chains up to 5 hops.  A chain is
flagged when:
- Length ≥ 3 hops
- All *intermediate* nodes have total degree ≤ 3 (shell / mule characteristics)

Label: `"layered_shell_chain"` | Base contribution: **+25 points**

### 4. False-Positive Merchant Reduction
Accounts are classified as **likely legitimate merchants** when:
1. Active for ≥ 30 days
2. Transaction amount CV ≤ 0.30 (consistent pricing)
3. Inter-arrival time CV ≤ 0.50 (regular cadence)

Matching accounts receive a **−25 point** reduction to minimise false positives.

### 5. Suspicion Scoring Model
```
Score = Σ(pattern weights) + velocity_burst + centrality_anomaly − merchant_fp
Clamped to [0, 100], rounded to 1 decimal place.
```

| Signal                      | Weight |
|-----------------------------|--------|
| Cycle participation         | +40    |
| Smurfing (fan-in/out)       | +30    |
| Layered shell chain         | +25    |
| High-velocity burst (24 h)  | +20    |
| Degree centrality anomaly   | +10    |
| Merchant FP reduction       | −25    |

---

## Complexity Analysis

| Component                | Time Complexity        | Notes                              |
|--------------------------|------------------------|------------------------------------|
| CSV parsing              | O(n)                   | Single Pandas read pass            |
| Graph construction       | O(n)                   | One edge per transaction row       |
| Cycle detection          | O((V+E)(C+1))          | Johnson's; C = circuit count       |
| Smurfing (sliding window)| O(n log n)             | Sort + two-pointer per account     |
| Shell detection (DFS)    | O(V · E^d)             | d = max depth (5); pruned early    |
| Scoring                  | O(A + R)               | A=accounts, R=rings                |
| **Total (typical)**      | **< 10 s @ 10k rows**  | Measured on M1 MacBook, 10k TX     |

---

## Setup & Run

### Prerequisites
- Python 3.10 or newer
- pip

### Install

```bash
cd backend
python -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### Run (development)

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Server is available at **http://localhost:8000**

Interactive docs: **http://localhost:8000/docs**

### Run (production)

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

---

## Docker

```bash
# Build image
docker build -t fraudai-backend .

# Run container
docker run -p 8000:8000 fraudai-backend
```

---

## Example CSV & Response

### `transactions.csv`
```csv
transaction_id,sender_id,receiver_id,amount,timestamp
TX001,ACC_A,ACC_B,500.00,2025-01-01 09:00:00
TX002,ACC_B,ACC_C,490.00,2025-01-01 10:00:00
TX003,ACC_C,ACC_A,480.00,2025-01-01 11:00:00
TX004,ACC_D,ACC_A,1000.00,2025-01-02 08:00:00
TX005,ACC_E,ACC_A,1100.00,2025-01-02 08:30:00
```

### Response excerpt
```json
{
  "suspicious_accounts": [
    {"account_id": "ACC_A", "suspicion_score": 65.0,
     "detected_patterns": ["cycle_length_3"], "ring_id": "RING_001"},
    {"account_id": "ACC_B", "suspicion_score": 40.0,
     "detected_patterns": ["cycle_length_3"], "ring_id": "RING_001"},
    {"account_id": "ACC_C", "suspicion_score": 40.0,
     "detected_patterns": ["cycle_length_3"], "ring_id": "RING_001"}
  ],
  "fraud_rings": [
    {"ring_id": "RING_001", "member_accounts": ["ACC_A","ACC_B","ACC_C"],
     "pattern_type": "cycle", "risk_score": 48.3}
  ],
  "summary": {
    "total_accounts_analyzed": 5,
    "suspicious_accounts_flagged": 3,
    "fraud_rings_detected": 1,
    "processing_time_seconds": 0.042
  }
}
```

---

## Environment Variables (optional overrides)

| Variable          | Default | Description                      |
|-------------------|---------|----------------------------------|
| `PORT`            | `8000`  | Uvicorn listen port              |

All detection thresholds live in `app/core/config.py` and can be overridden
without touching business logic.

---

*Advanced Money Muling Detection Platform*
