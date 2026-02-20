# Railway Quick Reference

## Service Configuration

### Backend Service
```
Name: backend
Root Directory: backend
Builder: Dockerfile
Port: $PORT (auto-assigned by Railway)
Health Check: /health
```

### Frontend Service
```
Name: dashboard
Root Directory: dashboard
Builder: Nixpacks
Port: $PORT (auto-assigned by Railway)
Health Check: /
```

## Environment Variables

### Backend
```bash
# Automatically provided by Railway
PORT=8000
```

### Frontend
```bash
# Required - Set after backend deploys
NEXT_PUBLIC_API_URL=https://your-backend-url.railway.app

# Required - Your Supabase credentials
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_key
```

## Deployment Checklist

- [ ] Push code to GitHub
- [ ] Create backend service in Railway
- [ ] Set backend Root Directory to `backend`
- [ ] Wait for backend to deploy
- [ ] Copy backend URL
- [ ] Create frontend service in Railway
- [ ] Set frontend Root Directory to `dashboard`
- [ ] Add environment variables to frontend
- [ ] Deploy frontend
- [ ] Test both services

## Testing Endpoints

```bash
# Backend health check
curl https://your-backend-url.railway.app/health

# Backend analyze endpoint (with file)
curl -X POST https://your-backend-url.railway.app/analyze \
  -F "file=@test_transactions.csv"

# Frontend
open https://your-frontend-url.railway.app
```

## Common Issues

| Issue | Solution |
|-------|----------|
| "No package.json found" | Set Root Directory to `dashboard` |
| "No requirements.txt found" | Set Root Directory to `backend` |
| Frontend can't connect to backend | Update `NEXT_PUBLIC_API_URL` |
| Build fails with nodejs-20_x error | Already fixed - uses `nodejs_20` |

## File Structure

```
project/
├── backend/
│   ├── railway.toml          ← Railway config
│   ├── nixpacks.toml         ← Build config
│   ├── Dockerfile            ← Docker build
│   ├── requirements.txt      ← Python deps
│   └── main.py              ← Entry point
│
└── dashboard/
    ├── railway.toml          ← Railway config
    ├── nixpacks.toml         ← Build config
    ├── package.json          ← Node deps
    └── app/                  ← Next.js app
```

## Support

- Railway Docs: https://docs.railway.app
- Nixpacks Docs: https://nixpacks.com
- This project: See RAILWAY_DEPLOYMENT.md
