#!/bin/bash

# Railway Deployment Setup Script
# This script helps you set up separate deployments for backend and frontend

echo "🚂 Railway Deployment Setup"
echo "================================"
echo ""

echo "📋 Project Structure:"
echo "  ├── backend/     (Python FastAPI)"
echo "  └── dashboard/   (Next.js)"
echo ""

echo "✅ Configuration files are ready:"
echo "  ✓ backend/railway.toml"
echo "  ✓ backend/nixpacks.toml"
echo "  ✓ backend/Dockerfile"
echo "  ✓ dashboard/railway.toml"
echo "  ✓ dashboard/nixpacks.toml"
echo ""

echo "📝 Next Steps in Railway Dashboard:"
echo ""
echo "1️⃣  CREATE BACKEND SERVICE:"
echo "   - Click 'New Service'"
echo "   - Connect your GitHub repo"
echo "   - Service Name: 'backend' or 'api'"
echo "   - ⚠️  IMPORTANT: Set Root Directory to: backend"
echo "   - Deploy and wait for it to finish"
echo "   - Copy the backend URL (e.g., https://backend-production.up.railway.app)"
echo ""

echo "2️⃣  CREATE FRONTEND SERVICE:"
echo "   - Click 'New Service' again"
echo "   - Connect the same GitHub repo"
echo "   - Service Name: 'dashboard' or 'frontend'"
echo "   - ⚠️  IMPORTANT: Set Root Directory to: dashboard"
echo ""

echo "3️⃣  CONFIGURE FRONTEND ENVIRONMENT VARIABLES:"
echo "   In the frontend service, add these variables:"
echo "   - NEXT_PUBLIC_API_URL = [your-backend-url-from-step-1]"
echo "   - NEXT_PUBLIC_SUPABASE_URL = [your-supabase-url]"
echo "   - NEXT_PUBLIC_SUPABASE_ANON_KEY = [your-supabase-key]"
echo ""

echo "4️⃣  DEPLOY:"
echo "   - Both services will deploy automatically"
echo "   - Backend builds with Docker"
echo "   - Frontend builds with Nixpacks"
echo ""

echo "🔍 VERIFY DEPLOYMENT:"
echo "   Backend health: [backend-url]/health"
echo "   Frontend: [frontend-url]"
echo ""

echo "📚 For detailed instructions, see: RAILWAY_DEPLOYMENT.md"
echo ""
