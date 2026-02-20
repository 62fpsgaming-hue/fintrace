# Railway Deployment Checklist

Use this checklist to deploy your application step by step.

## Pre-Deployment

- [ ] Code is committed to GitHub
- [ ] You have a Railway account
- [ ] You have Supabase credentials ready

## Backend Deployment

### Create Backend Service
- [ ] Go to Railway dashboard
- [ ] Click "New Project" or open existing project
- [ ] Click "New Service"
- [ ] Select "Deploy from GitHub repo"
- [ ] Choose your repository
- [ ] Service name: `backend` or `api`

### Configure Backend
- [ ] Click on service settings (gear icon)
- [ ] Find "Root Directory" setting
- [ ] Set to: `backend`
- [ ] Save changes

### Wait for Backend Deploy
- [ ] Watch build logs
- [ ] Wait for "Success" status
- [ ] Click on service to see details
- [ ] Copy the service URL (e.g., `https://backend-production-xxxx.up.railway.app`)
- [ ] Test health endpoint: `[backend-url]/health`

## Frontend Deployment

### Create Frontend Service
- [ ] In same Railway project, click "New Service"
- [ ] Select "Deploy from GitHub repo"
- [ ] Choose the SAME repository
- [ ] Service name: `dashboard` or `frontend`

### Configure Frontend
- [ ] Click on service settings (gear icon)
- [ ] Find "Root Directory" setting
- [ ] Set to: `dashboard`
- [ ] Save changes

### Set Environment Variables
- [ ] Click on "Variables" tab
- [ ] Add variable: `NEXT_PUBLIC_API_URL`
  - Value: [your-backend-url-from-above]
- [ ] Add variable: `NEXT_PUBLIC_SUPABASE_URL`
  - Value: [your-supabase-project-url]
- [ ] Add variable: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
  - Value: [your-supabase-anon-key]
- [ ] Save variables

### Wait for Frontend Deploy
- [ ] Watch build logs
- [ ] Wait for "Success" status
- [ ] Copy the frontend URL

## Verification

### Test Backend
- [ ] Visit: `[backend-url]/health`
- [ ] Should see: `{"status":"healthy"}`
- [ ] Check logs for any errors

### Test Frontend
- [ ] Visit: `[frontend-url]`
- [ ] Should see landing page
- [ ] Try logging in (if auth is set up)
- [ ] Try uploading a CSV file
- [ ] Check if it connects to backend

### Test Integration
- [ ] Upload `backend/test_transactions.csv`
- [ ] Verify analysis runs
- [ ] Check results display correctly
- [ ] Try downloading JSON report
- [ ] Try downloading CSV report

## Post-Deployment

### Update Documentation
- [ ] Save backend URL for reference
- [ ] Save frontend URL for reference
- [ ] Update any documentation with URLs

### Monitor Services
- [ ] Check Railway dashboard for metrics
- [ ] Review logs for errors
- [ ] Set up alerts (optional)

### Optional: Custom Domains
- [ ] Add custom domain to backend (optional)
- [ ] Add custom domain to frontend (optional)
- [ ] Update NEXT_PUBLIC_API_URL if backend domain changes

## Troubleshooting

If backend fails:
- [ ] Check Root Directory is set to `backend`
- [ ] Check Dockerfile exists in backend/
- [ ] Check requirements.txt exists
- [ ] Review build logs for errors

If frontend fails:
- [ ] Check Root Directory is set to `dashboard`
- [ ] Check package.json exists in dashboard/
- [ ] Check nixpacks.toml is correct
- [ ] Review build logs for errors

If frontend can't connect to backend:
- [ ] Verify NEXT_PUBLIC_API_URL is set correctly
- [ ] Verify backend is running and healthy
- [ ] Check CORS settings in backend
- [ ] Check browser console for errors

## Success Criteria

✅ Backend service is running
✅ Backend health check returns 200
✅ Frontend service is running
✅ Frontend loads in browser
✅ Can upload CSV and get analysis
✅ Can download reports
✅ No errors in logs

## Next Steps

After successful deployment:
1. Share the frontend URL with users
2. Monitor usage and performance
3. Set up continuous deployment (auto-deploy on git push)
4. Consider adding monitoring/analytics
5. Set up backup strategy

---

**Need Help?**
- See: RAILWAY_DEPLOYMENT.md for detailed guide
- See: RAILWAY_QUICK_REFERENCE.md for quick tips
- See: DEPLOYMENT_ARCHITECTURE.md for architecture overview
