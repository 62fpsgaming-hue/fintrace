# Vercel Deployment Guide - FinTrace Frontend

## Quick Deploy

### Option 1: Deploy via Vercel Dashboard (Recommended)

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Configure for Vercel deployment"
   git push origin main
   ```

2. **Import to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Import your GitHub repository: `62fpsgaming-hue/fintrace-frontend`
   - Select the `dashboard` directory as the root directory

3. **Configure Environment Variables**
   Add these in Vercel Dashboard → Settings → Environment Variables:
   
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   NEXT_PUBLIC_API_URL=your_backend_api_url
   ```

4. **Deploy**
   - Click "Deploy"
   - Vercel will automatically build and deploy your app
   - You'll get a URL like: `https://fintrace-frontend.vercel.app`

### Option 2: Deploy via Vercel CLI

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Login to Vercel**
   ```bash
   vercel login
   ```

3. **Deploy**
   ```bash
   vercel
   ```

4. **Set Environment Variables**
   ```bash
   vercel env add NEXT_PUBLIC_SUPABASE_URL
   vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY
   vercel env add NEXT_PUBLIC_API_URL
   ```

5. **Deploy to Production**
   ```bash
   vercel --prod
   ```

## Configuration Files

### vercel.json
- Configures build settings
- Sets up environment variables
- Adds security headers
- Optimizes for Next.js

### .vercelignore
- Excludes unnecessary files from deployment
- Reduces deployment size
- Speeds up build time

### next.config.mjs
- Optimized for Vercel
- Package import optimization
- Image optimization settings

## Environment Variables

Required environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `NEXT_PUBLIC_SUPABASE_URL` | Your Supabase project URL | `https://xxx.supabase.co` |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anonymous key | `eyJhbGc...` |
| `NEXT_PUBLIC_API_URL` | Backend API URL | `https://api.fintrace.com` |

## Automatic Deployments

Vercel automatically deploys:
- **Production**: Every push to `main` branch
- **Preview**: Every pull request
- **Development**: Every push to other branches

## Custom Domain Setup

1. Go to Vercel Dashboard → Your Project → Settings → Domains
2. Add your custom domain
3. Configure DNS records as instructed
4. SSL certificate is automatically provisioned

## Performance Optimizations

Vercel automatically provides:
- ✅ Edge Network (CDN)
- ✅ Automatic HTTPS
- ✅ Image Optimization
- ✅ Code Splitting
- ✅ Compression (Brotli/Gzip)
- ✅ HTTP/2 & HTTP/3
- ✅ Smart CDN Caching

## Build Settings

- **Framework Preset**: Next.js
- **Build Command**: `npm run build`
- **Output Directory**: `.next`
- **Install Command**: `npm install`
- **Development Command**: `npm run dev`

## Monitoring

Access deployment logs and analytics:
- Dashboard → Your Project → Deployments
- Real-time logs during build
- Runtime logs for debugging
- Analytics for performance metrics

## Troubleshooting

### Build Fails

1. Check build logs in Vercel Dashboard
2. Verify all environment variables are set
3. Test build locally: `npm run build`
4. Check Node.js version compatibility

### Environment Variables Not Working

1. Ensure variables start with `NEXT_PUBLIC_` for client-side access
2. Redeploy after adding new variables
3. Check variable names match exactly

### API Connection Issues

1. Verify `NEXT_PUBLIC_API_URL` is correct
2. Check CORS settings on backend
3. Ensure backend is deployed and accessible

## Rollback

To rollback to a previous deployment:
1. Go to Vercel Dashboard → Deployments
2. Find the working deployment
3. Click "..." → "Promote to Production"

## CI/CD Integration

Vercel automatically integrates with:
- GitHub
- GitLab
- Bitbucket

Every commit triggers:
1. Automatic build
2. Preview deployment
3. Deployment URL in PR comments

## Cost

- **Hobby Plan**: Free
  - Unlimited deployments
  - 100GB bandwidth/month
  - Automatic HTTPS
  - Edge Network

- **Pro Plan**: $20/month
  - Everything in Hobby
  - Advanced analytics
  - Team collaboration
  - Priority support

## Support

- Documentation: https://vercel.com/docs
- Community: https://github.com/vercel/vercel/discussions
- Support: support@vercel.com

## Next Steps

1. ✅ Deploy to Vercel
2. ✅ Configure environment variables
3. ✅ Set up custom domain (optional)
4. ✅ Enable analytics
5. ✅ Configure backend API URL
6. ✅ Test the deployment

Your FinTrace frontend is now live on Vercel! 🚀
