# Deployment Guide - Quick Start

Your project is now configured for separate backend and frontend deployment on Railway! 🚀

## What's Been Set Up

✅ Fixed Nixpacks configuration (nodejs_20, nodePackages.pnpm)
✅ Configured backend service (Dockerfile-based)
✅ Configured frontend service (Nixpacks-based)
✅ Created comprehensive deployment documentation

## Quick Start (3 Steps)

### 1. Deploy Backend
- Create service in Railway
- Set Root Directory: `backend`
- Copy the deployed URL

### 2. Deploy Frontend
- Create another service in Railway
- Set Root Directory: `dashboard`
- Add environment variable: `NEXT_PUBLIC_API_URL` = [backend-url]

### 3. Test
- Visit frontend URL
- Upload CSV file
- Verify analysis works

## Documentation Files

| File | Purpose |
|------|---------|
| `DEPLOYMENT_CHECKLIST.md` | ✅ Step-by-step checklist |
| `RAILWAY_DEPLOYMENT.md` | 📚 Detailed deployment guide |
| `RAILWAY_QUICK_REFERENCE.md` | ⚡ Quick reference card |
| `DEPLOYMENT_ARCHITECTURE.md` | 🏗️ Architecture diagrams |
| `SETUP_RAILWAY.sh` | 🔧 Setup instructions script |
| `railway-services-config.json` | ⚙️ Service configuration template |

## Key Configuration Files

### Backend
- `backend/railway.toml` - Railway deployment config
- `backend/nixpacks.toml` - Build configuration
- `backend/Dockerfile` - Docker build instructions

### Frontend
- `dashboard/railway.toml` - Railway deployment config
- `dashboard/nixpacks.toml` - Build configuration (fixed!)
- `dashboard/.env.local.example` - Environment variables template

## Most Important Thing

⚠️ **Set Root Directory correctly in Railway:**
- Backend service → Root Directory: `backend`
- Frontend service → Root Directory: `dashboard`

Without this, Railway won't find the package.json or requirements.txt files!

## Need Help?

1. Run: `./SETUP_RAILWAY.sh` to see setup instructions
2. Follow: `DEPLOYMENT_CHECKLIST.md` for step-by-step guide
3. Reference: `RAILWAY_QUICK_REFERENCE.md` for quick answers

## What Was Fixed

The original error was caused by incorrect Nix package names:
- ❌ `nodejs-20_x` → ✅ `nodejs_20`
- ❌ `pnpm` → ✅ `nodePackages.pnpm`

These are now corrected in both `nixpacks.toml` files.

## Architecture

```
Railway Project
├── Backend Service (backend/)
│   └── FastAPI + Python 3.11
│       └── https://backend-xxx.railway.app
│
└── Frontend Service (dashboard/)
    └── Next.js + Node.js 20
        └── https://dashboard-xxx.railway.app
            └── Connects to backend via NEXT_PUBLIC_API_URL
```

## Support

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- This Project: See documentation files above

---

**Ready to deploy?** Start with `DEPLOYMENT_CHECKLIST.md`! ✨
