# Developer Guide - RIFT Dashboard

## 🚀 Quick Start

### Prerequisites

```bash
# Required
- Node.js 20+
- pnpm (or npm/yarn)
- Python 3.11+
- Git

# Optional (for auth & history)
- Supabase account
```

### Installation

```bash
# Clone repository
git clone <repository-url>
cd fraudai

# Install backend dependencies
cd backend
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt

# Install frontend dependencies
cd ../dashboard
pnpm install
```

### Environment Setup

```bash
# Frontend (.env.local)
cd dashboard
cp .env.local.example .env.local

# Edit .env.local
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url  # Optional
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key      # Optional
```

### Running the Application

```bash
# Terminal 1: Start backend
cd backend
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Terminal 2: Start frontend
cd dashboard
pnpm dev
```

Open browser to `http://localhost:3000`

---

## 📁 Project Structure

```
fraudai/
├── backend/                    # FastAPI backend
│   ├── app/
│   │   ├── api/               # API routes
│   │   │   └── routes.py      # POST /analyze endpoint
│   │   ├── core/              # Configuration
│   │   │   └── config.py      # Detection thresholds
│   │   ├── models/            # Pydantic schemas
│   │   │   └── schemas.py     # Response models
│   │   └── services/          # Business logic
│   │       ├── csv_parser.py
│   │       ├── graph_builder.py
│   │       ├── pattern_detector.py
│   │       ├── scoring_engine.py
│   │       └── json_formatter.py
│   ├── main.py                # FastAPI app
│   ├── requirements.txt
│   └── test_transactions.csv
│
├── dashboard/                  # Next.js frontend
│   ├── app/                   # App router
│   │   ├── auth/             # Auth pages
│   │   ├── dashboard/        # Dashboard page
│   │   ├── globals.css       # Global styles
│   │   ├── layout.tsx        # Root layout
│   │   └── page.tsx          # Landing page
│   ├── components/
│   │   ├── dashboard/        # Dashboard components
│   │   │   ├── dashboard-shell.tsx
│   │   │   ├── user-dashboard.tsx
│   │   │   ├── user-stats-cards.tsx
│   │   │   ├── analysis-chart.tsx
│   │   │   └── analysis-history-table.tsx
│   │   ├── landing/          # Landing page components
│   │   │   ├── navbar.tsx
│   │   │   ├── hero.tsx
│   │   │   ├── features.tsx
│   │   │   ├── how-it-works.tsx
│   │   │   ├── cta.tsx
│   │   │   └── footer.tsx
│   │   ├── ui/               # Reusable UI components
│   │   ├── graph-view.tsx
│   │   ├── rings-table.tsx
│   │   ├── suspicious-accounts.tsx
│   │   ├── summary-cards.tsx
│   │   ├── upload-panel.tsx
│   │   └── node-details-panel.tsx
│   ├── lib/
│   │   ├── supabase/         # Supabase client
│   │   ├── api.ts            # API client
│   │   ├── store.ts          # Zustand store
│   │   ├── types.ts          # TypeScript types
│   │   └── utils.ts          # Utilities
│   ├── package.json
│   └── pnpm-lock.yaml
│
├── FEATURES.md
├── SETUP_GUIDE.md
├── IMPLEMENTATION_STATUS.md
├── TESTING_GUIDE.md
├── UI_IMPROVEMENTS.md
├── VISUAL_GUIDE.md
└── DEVELOPER_GUIDE.md (this file)
```

---

## 🔧 Development Workflow

### Making Changes

#### Backend Changes

```bash
# 1. Edit files in backend/app/
# 2. Backend auto-reloads with --reload flag
# 3. Test changes
curl -X POST http://localhost:8000/analyze \
  -F "file=@test_transactions.csv"

# 4. Run tests
pytest test_main.py -v

# 5. Validate output format
python validate_output.py response.json
```

#### Frontend Changes

```bash
# 1. Edit files in dashboard/
# 2. Frontend auto-reloads (Fast Refresh)
# 3. Check browser console for errors
# 4. Test responsive design (DevTools)
# 5. Verify TypeScript types
pnpm type-check
```

### Adding New Features

#### Backend: Add New Detection Pattern

1. **Update config** (`backend/app/core/config.py`):
```python
# Add new threshold
NEW_PATTERN_THRESHOLD = 5
```

2. **Add detector** (`backend/app/services/pattern_detector.py`):
```python
def detect_new_pattern(
    G: nx.DiGraph,
    ring_counter: list[int],
) -> list[dict[str, Any]]:
    """Detect new pattern."""
    rings = []
    # Detection logic here
    return rings
```

3. **Update scoring** (`backend/app/services/scoring_engine.py`):
```python
SCORE_NEW_PATTERN = 15.0

# Add to scoring logic
if ptype == "new_pattern":
    delta = SCORE_NEW_PATTERN
```

4. **Test**:
```bash
pytest test_main.py -v
```

#### Frontend: Add New Component

1. **Create component** (`dashboard/components/my-component.tsx`):
```tsx
'use client'

import { Card } from '@/components/ui/card'

export function MyComponent() {
  return (
    <Card>
      {/* Component content */}
    </Card>
  )
}
```

2. **Add types** (`dashboard/lib/types.ts`):
```typescript
export interface MyData {
  id: string
  value: number
}
```

3. **Use component**:
```tsx
import { MyComponent } from '@/components/my-component'

export default function Page() {
  return <MyComponent />
}
```

---

## 🎨 Styling Guide

### Using Tailwind Classes

```tsx
// Good: Use utility classes
<div className="flex items-center gap-4 rounded-lg bg-card p-6 shadow-sm">

// Better: Use semantic tokens
<div className="flex items-center gap-4 rounded-lg bg-card p-6 shadow-sm hover:shadow-md transition-shadow">

// Best: Combine with custom utilities
<div className="glass flex items-center gap-4 rounded-lg p-6">
```

### Custom Utilities

```css
/* globals.css */
.gradient-text {
  @apply bg-gradient-to-r from-primary via-forensic-ring to-primary bg-clip-text text-transparent;
}

.glass {
  @apply bg-card/80 backdrop-blur-md;
}
```

### Color Usage

```tsx
// Semantic colors
<div className="text-danger">Error</div>
<div className="text-success">Success</div>
<div className="text-warning">Warning</div>
<div className="text-primary">Primary</div>
<div className="text-forensic-ring">Ring</div>

// Neutral colors
<div className="text-foreground">Main text</div>
<div className="text-muted-foreground">Secondary text</div>
<div className="bg-background">Background</div>
<div className="bg-card">Card background</div>
```

---

## 🧪 Testing

### Backend Tests

```bash
# Run all tests
cd backend
pytest test_main.py -v

# Run specific test
pytest test_main.py::test_analyze_endpoint -v

# With coverage
pytest --cov=app test_main.py
```

### Frontend Tests

```bash
# Type checking
pnpm type-check

# Linting
pnpm lint

# Build test
pnpm build
```

### Manual Testing

```bash
# Test API endpoint
curl -X POST http://localhost:8000/analyze \
  -F "file=@test_transactions.csv" \
  -o response.json

# Validate output
python validate_output.py response.json

# Test with large file
python generate_test_data.py --rows 10000
curl -X POST http://localhost:8000/analyze \
  -F "file=@large_test.csv"
```

---

## 🐛 Debugging

### Backend Debugging

```python
# Add print statements
print(f"Debug: {variable}")

# Use logging
import logging
logging.info(f"Processing {len(df)} transactions")

# Use debugger
import pdb; pdb.set_trace()

# Check FastAPI logs
# Logs appear in terminal where uvicorn is running
```

### Frontend Debugging

```tsx
// Console logging
console.log('Debug:', data)

// React DevTools
// Install React DevTools browser extension

// Network tab
// Check API requests in browser DevTools

// Zustand DevTools
// Install Redux DevTools extension
```

### Common Issues

#### Backend: "Missing required columns"
```bash
# Check CSV format
head test_transactions.csv

# Required columns:
# transaction_id, sender_id, receiver_id, amount, timestamp
```

#### Frontend: "API connection failed"
```bash
# Check backend is running
curl http://localhost:8000/health

# Check NEXT_PUBLIC_API_URL in .env.local
cat .env.local | grep API_URL
```

#### Frontend: "Graph not rendering"
```bash
# Check browser console for errors
# Verify vis-network is loaded
# Try clearing browser cache
```

---

## 📦 Building for Production

### Backend

```bash
cd backend

# Install production dependencies
pip install -r requirements.txt

# Run with gunicorn
gunicorn main:app -w 4 -k uvicorn.workers.UvicornWorker

# Or with uvicorn
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

### Frontend

```bash
cd dashboard

# Build
pnpm build

# Test production build locally
pnpm start

# Deploy to Vercel
vercel deploy --prod
```

### Docker

```bash
# Build backend
cd backend
docker build -t fraudai-backend .
docker run -p 8000:8000 fraudai-backend

# Build frontend
cd dashboard
docker build -f Dockerfile.frontend -t fraudai-frontend .
docker run -p 3000:3000 fraudai-frontend
```

---

## 🔐 Environment Variables

### Backend

```bash
# Optional
PORT=8000
CORS_ORIGINS=*  # Set to frontend domain in production
```

### Frontend

```bash
# Required
NEXT_PUBLIC_API_URL=http://localhost:8000

# Optional (for auth & history)
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJxxx...
```

---

## 📚 Key Libraries

### Backend

```python
fastapi==0.109.0      # Web framework
uvicorn==0.27.0       # ASGI server
networkx==3.2.1       # Graph algorithms
pandas==2.2.0         # Data processing
numpy==1.26.3         # Numerical computing
pydantic==2.5.3       # Data validation
```

### Frontend

```json
{
  "next": "15.0.0",           // React framework
  "react": "19.0.0",          // UI library
  "typescript": "5.3.3",      // Type safety
  "tailwindcss": "3.4.1",     // Styling
  "zustand": "4.4.7",         // State management
  "vis-network": "9.1.9",     // Graph visualization
  "recharts": "2.10.3",       // Charts
  "@supabase/supabase-js": "2.39.0"  // Auth & DB
}
```

---

## 🎯 Performance Tips

### Backend

```python
# Use vectorized operations
df['new_col'] = df['col1'] + df['col2']  # Good
# vs
df['new_col'] = df.apply(lambda x: x['col1'] + x['col2'], axis=1)  # Slow

# Cache expensive computations
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_function(param):
    # ...
```

### Frontend

```tsx
// Use React.memo for expensive components
export const ExpensiveComponent = React.memo(({ data }) => {
  // ...
})

// Use useMemo for expensive calculations
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(data)
}, [data])

// Use useCallback for event handlers
const handleClick = useCallback(() => {
  // ...
}, [dependency])

// Lazy load components
const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <Skeleton />
})
```

---

## 🔄 Git Workflow

```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes
git add .
git commit -m "feat: add new detection pattern"

# Push to remote
git push origin feature/my-feature

# Create pull request on GitHub

# After merge, update main
git checkout main
git pull origin main
```

### Commit Message Convention

```
feat: add new feature
fix: fix bug
docs: update documentation
style: format code
refactor: refactor code
test: add tests
chore: update dependencies
```

---

## 📖 API Documentation

### Interactive Docs

```bash
# Swagger UI
http://localhost:8000/docs

# ReDoc
http://localhost:8000/redoc
```

### Endpoints

```
POST /analyze
  - Upload CSV file
  - Returns AnalysisResponse JSON

GET /health
  - Health check
  - Returns {"status": "ok"}

POST /export/csv
  - Export analysis as CSV
  - Returns CSV file
```

---

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Add tests
5. Update documentation
6. Submit pull request

### Code Style

```bash
# Backend: Black formatter
black backend/

# Frontend: Prettier
pnpm format
```

---

## 📞 Support

- **Documentation**: Check README files
- **Issues**: Open GitHub issue
- **API Docs**: http://localhost:8000/docs
- **Testing**: See TESTING_GUIDE.md

---

## 🎓 Learning Resources

### Backend
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [NetworkX Documentation](https://networkx.org/documentation/stable/)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

### Frontend
- [Next.js Documentation](https://nextjs.org/docs)
- [React Documentation](https://react.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [shadcn/ui Components](https://ui.shadcn.com/)

---

Happy coding! 🚀
