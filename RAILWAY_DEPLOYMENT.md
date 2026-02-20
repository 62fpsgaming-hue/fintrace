# Railway Deployment Guide

This project uses a monorepo structure with separate frontend and backend services.

## Project Structure
```
.
├── backend/          # Python FastAPI backend
└── dashboard/        # Next.js frontend
```

## Deployment Steps

### 1. Create Two Services in Railway

In your Railway project, create two separate services:

#### Service 1: Backend API
- **Name**: `backend` or `api`
- **Root Directory**: `backend`
- **Builder**: Dockerfile (configured in railway.toml)

#### Service 2: Frontend Dashboard
- **Name**: `dashboard` or `frontend`
- **Root Directory**: `dashboard`
- **Builder**: Nixpacks (configured in railway.toml)

### 2. Configure Environment Variables

#### Backend Service Environment Variables:
```
PORT=8000
PYTHON_VERSION=3.11
```

#### Frontend Service Environment Variables:
```
NEXT_PUBLIC_API_URL=https://your-backend-url.railway.app
```
(Replace with your actual backend Railway URL after it deploys)

### 3. Deploy

1. **Deploy Backend First**:
   - Push your code to GitHub
   - Railway will automatically detect the backend service
   - Wait for it to deploy and get the URL

2. **Deploy Frontend**:
   - Update `NEXT_PUBLIC_API_URL` with the backend URL
   - Railway will build and deploy the frontend

### 4. Verify Deployment

- Backend health check: `https://your-backend-url.railway.app/health`
- Frontend: `https://your-frontend-url.railway.app`

## Configuration Files

Each service has its own configuration:

### Backend (`backend/`)
- `railway.toml` - Railway deployment config
- `Dockerfile` - Docker build instructions
- `requirements.txt` - Python dependencies

### Frontend (`dashboard/`)
- `railway.toml` - Railway deployment config
- `nixpacks.toml` - Nixpacks build config
- `package.json` - Node.js dependencies

## Troubleshooting

### "No package.json found"
- Make sure Root Directory is set to `dashboard` for frontend service

### "No requirements.txt found"
- Make sure Root Directory is set to `backend` for backend service

### Backend not connecting
- Verify `NEXT_PUBLIC_API_URL` is set correctly in frontend service
- Check backend health endpoint is responding

## Notes

- Each service deploys independently
- Changes to backend/ only trigger backend deployment
- Changes to dashboard/ only trigger frontend deployment
- Both services can scale independently
