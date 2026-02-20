# Deployment Architecture

## Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     Railway Project                          │
│                                                              │
│  ┌────────────────────────┐    ┌─────────────────────────┐ │
│  │   Backend Service      │    │   Frontend Service      │ │
│  │                        │    │                         │ │
│  │  Root: backend/        │◄───│  Root: dashboard/       │ │
│  │  Builder: Dockerfile   │    │  Builder: Nixpacks      │ │
│  │  Port: $PORT          │    │  Port: $PORT           │ │
│  │                        │    │                         │ │
│  │  ┌──────────────────┐ │    │  ┌──────────────────┐  │ │
│  │  │  FastAPI App     │ │    │  │  Next.js App     │  │ │
│  │  │  Python 3.11     │ │    │  │  Node.js 20      │  │ │
│  │  │  Uvicorn Server  │ │    │  │  React 19        │  │ │
│  │  └──────────────────┘ │    │  └──────────────────┘  │ │
│  │                        │    │                         │ │
│  │  Endpoints:            │    │  Environment:           │ │
│  │  • /health            │    │  • NEXT_PUBLIC_API_URL  │ │
│  │  • /analyze           │    │  • NEXT_PUBLIC_SUPABASE │ │
│  │  • /export/csv        │    │                         │ │
│  └────────────────────────┘    └─────────────────────────┘ │
│           │                              │                  │
│           │ https://backend.railway.app  │                  │
│           │                              │                  │
│           └──────────────────────────────┘                  │
│                  API Connection                             │
└─────────────────────────────────────────────────────────────┘
```

## Deployment Flow

### Step 1: Backend Deployment
```
GitHub Repo
    │
    ├─► Railway detects backend/
    │   
    ├─► Reads backend/railway.toml
    │   
    ├─► Builds using backend/Dockerfile
    │   
    ├─► Installs requirements.txt
    │   
    ├─► Starts: uvicorn main:app
    │   
    └─► Assigns URL: https://backend-xxx.railway.app
```

### Step 2: Frontend Deployment
```
GitHub Repo
    │
    ├─► Railway detects dashboard/
    │   
    ├─► Reads dashboard/railway.toml
    │   
    ├─► Uses dashboard/nixpacks.toml
    │   
    ├─► Installs: pnpm install
    │   
    ├─► Builds: pnpm build
    │   
    ├─► Starts: pnpm start
    │   
    └─► Assigns URL: https://dashboard-xxx.railway.app
```

## Service Communication

```
User Browser
     │
     ├─► Visits: https://dashboard-xxx.railway.app
     │
     ├─► Frontend loads
     │
     ├─► User uploads CSV
     │
     ├─► Frontend sends to: NEXT_PUBLIC_API_URL
     │                       (backend URL)
     │
     ├─► Backend processes
     │
     ├─► Returns JSON response
     │
     └─► Frontend displays results
```

## Environment Variables Flow

```
Backend Service
├─ PORT (auto-assigned by Railway)
└─ PYTHON_VERSION=3.11

Frontend Service
├─ NEXT_PUBLIC_API_URL=https://backend-xxx.railway.app
├─ NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
└─ NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key
```

## File Structure in Railway

```
Railway Project
│
├─ Service: backend
│  └─ Root Directory: backend/
│     ├─ railway.toml       (Railway config)
│     ├─ nixpacks.toml      (Build config)
│     ├─ Dockerfile         (Docker build)
│     ├─ requirements.txt   (Dependencies)
│     ├─ main.py           (Entry point)
│     └─ app/              (Application code)
│
└─ Service: dashboard
   └─ Root Directory: dashboard/
      ├─ railway.toml       (Railway config)
      ├─ nixpacks.toml      (Build config)
      ├─ package.json       (Dependencies)
      ├─ next.config.js     (Next.js config)
      └─ app/              (Application code)
```

## Build Process

### Backend (Dockerfile)
```dockerfile
1. FROM python:3.11-slim
2. Install system dependencies (gcc, build-essential)
3. COPY requirements.txt
4. RUN pip install -r requirements.txt
5. COPY application code
6. CMD uvicorn main:app --host 0.0.0.0 --port $PORT
```

### Frontend (Nixpacks)
```bash
1. Setup: Install nodejs_20 + nodePackages.pnpm
2. Install: pnpm install --frozen-lockfile
3. Build: pnpm build (Next.js production build)
4. Start: pnpm start (Next.js production server)
```

## Monitoring

### Health Checks
- Backend: `GET /health` → Returns 200 OK
- Frontend: `GET /` → Returns 200 OK

### Logs
- View in Railway dashboard
- Each service has separate logs
- Real-time log streaming available

## Scaling

Both services can scale independently:
- Backend: Handle more API requests
- Frontend: Serve more users
- No coordination needed between services
