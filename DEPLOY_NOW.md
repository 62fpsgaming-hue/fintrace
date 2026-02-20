# 🚀 Deploy to Railway - Quick Start

## ⚡ 3-Step Deployment

### Step 1: Commit and Push
```bash
git add .
git commit -m "Configure for Railway deployment"
git push origin main
```

### Step 2: Create Railway Project
1. Go to **[railway.app](https://railway.app)** and sign in
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose your repository
5. Railway will detect both services automatically

### Step 3: Configure Services

#### Backend Service (Auto-detected)
- **Name**: `fintrace-backend`
- **Root Directory**: `backend`
- **Environment Variables**: None needed ✅
- Click **"Deploy"**

After deployment:
1. Go to **Settings → Networking**
2. Click **"Generate Domain"**
3. **Copy the URL** (e.g., `https://fintrace-backend-production.up.railway.app`)

#### Frontend Service
1. Click **"New Service"** in your project
2. Select the **same GitHub repo**
3. Configure:
   - **Name**: `fintrace-frontend`
   - **Root Directory**: `dashboard`

4. Add **Environment Variables**:
   ```
   NEXT_PUBLIC_API_URL=<paste-backend-url-here>
   NEXT_PUBLIC_SUPABASE_URL=https://jgtarpigzpcadrsdmfhm.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=sb_publishable_bCRMFF6rrbHWCREJry4uMQ_rSAU4j0M
   ```

5. Click **"Deploy"**

6. After deployment:
   - Go to **Settings → Networking**
   - Click **"Generate Domain"**
   - **Visit your app!** 🎉

## ✅ Verify Deployment

### Test Backend
```bash
curl https://your-backend-url.up.railway.app/health
```

Should return:
```json
{"status":"healthy","service":"Financial Forensics Engine","version":"1.0.0"}
```

### Test Frontend
Visit `https://your-frontend-url.up.railway.app` in your browser.

## 🔧 If Build Fails

### Common Issues:

1. **"Failed to build image"**
   - Check Railway logs for specific error
   - Verify all files are committed
   - Check `railway.toml` configuration

2. **"Module not found"**
   - Backend: Check `requirements.txt`
   - Frontend: Check `package.json`

3. **"Port binding error"**
   - Railway auto-provides `PORT` variable
   - No action needed

4. **Frontend can't connect to backend**
   - Verify `NEXT_PUBLIC_API_URL` is correct
   - Must include `https://`
   - No trailing slash
   - Redeploy frontend after changing env vars

## 📁 Files Created

All necessary files have been created:

✅ `backend/railway.toml` - Backend config
✅ `backend/nixpacks.toml` - Backend build config
✅ `backend/Dockerfile` - Backend container (updated)
✅ `backend/.dockerignore` - Backend exclusions

✅ `dashboard/railway.toml` - Frontend config
✅ `dashboard/nixpacks.toml` - Frontend build config
✅ `dashboard/Dockerfile.frontend` - Frontend container
✅ `dashboard/.dockerignore` - Frontend exclusions

✅ `.railwayignore` - Global exclusions
✅ `railway.json` - Project config

## 📚 Documentation

- `RAILWAY_SETUP.md` - Detailed setup guide
- `RAILWAY_DEPLOYMENT_GUIDE.md` - Comprehensive guide
- `README_RAILWAY.md` - Complete documentation
- `DEPLOY_NOW.md` - This quick start guide

## 🎯 What Railway Does Automatically

✅ Detects Dockerfile and builds container
✅ Assigns PORT environment variable
✅ Generates HTTPS domain
✅ Provides SSL certificate
✅ Monitors health checks
✅ Auto-deploys on Git push
✅ Provides logs and metrics

## 💡 Pro Tips

1. **Use Railway CLI** for faster deployments:
   ```bash
   npm i -g @railway/cli
   railway login
   railway up
   ```

2. **Monitor logs** in real-time:
   - Click service → "Logs" tab
   - Filter by log level

3. **Set up staging** environment:
   - Create new project
   - Deploy from `staging` branch

4. **Custom domain**:
   - Go to Settings → Networking
   - Add custom domain
   - Update DNS records

## 🆘 Need Help?

1. Check build logs in Railway dashboard
2. Review `RAILWAY_SETUP.md` for detailed troubleshooting
3. Visit [Railway Docs](https://docs.railway.app)
4. Join [Railway Discord](https://discord.gg/railway)

## ⏱️ Deployment Time

- Backend: ~2-3 minutes
- Frontend: ~3-5 minutes
- Total: ~5-8 minutes

## 💰 Cost

**Hobby Plan**: $5/month
- $5 credit included
- Good for testing and small projects

**Developer Plan**: $5/month
- $5 credit + $5 usage
- No sleep mode
- Better for production

## 🎉 You're Ready!

Everything is configured and ready to deploy. Just follow the 3 steps above!

---

**Questions?** Check `RAILWAY_SETUP.md` for detailed instructions.
