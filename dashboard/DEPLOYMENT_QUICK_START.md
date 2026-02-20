# Quick Start - Deploy to Vercel

## 🚀 Fastest Way to Deploy

### Method 1: One-Click Deploy (Easiest)

1. Click this button:
   
   [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/62fpsgaming-hue/fintrace-frontend&root-directory=dashboard)

2. Connect your GitHub account
3. Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `NEXT_PUBLIC_API_URL`
4. Click "Deploy"

### Method 2: GitHub Integration (Recommended)

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Configure for Vercel"
   git push origin main
   ```

2. **Import to Vercel**
   - Go to https://vercel.com/new
   - Select your repository
   - Set root directory to `dashboard`
   - Click "Deploy"

3. **Add Environment Variables**
   - Go to Settings → Environment Variables
   - Add your Supabase and API credentials

### Method 3: CLI Deploy

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
./deploy-vercel.sh
```

## 📋 Required Environment Variables

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_API_URL=https://your-backend-api.com
```

## ✅ Checklist

- [ ] Code pushed to GitHub
- [ ] Vercel account created
- [ ] Repository imported to Vercel
- [ ] Environment variables configured
- [ ] Deployment successful
- [ ] Custom domain configured (optional)

## 🔗 Useful Links

- **Vercel Dashboard**: https://vercel.com/dashboard
- **Documentation**: See `VERCEL_DEPLOYMENT.md`
- **Support**: https://vercel.com/support

## 🎉 That's It!

Your FinTrace frontend is now live on Vercel with:
- ✅ Automatic HTTPS
- ✅ Global CDN
- ✅ Automatic deployments on push
- ✅ Preview deployments for PRs
- ✅ Zero configuration needed

Visit your deployment URL to see your app live! 🚀
