#!/bin/bash

# UI Fix Installation Script
# This script fixes the Tailwind CSS v4 configuration issues

echo "🔧 Fixing RIFT Dashboard UI Issues (Tailwind v4)..."
echo ""

# Navigate to dashboard directory
cd dashboard || exit 1

echo "📦 Installing Tailwind v4 dependencies..."
if command -v pnpm &> /dev/null; then
    echo "Using pnpm..."
    pnpm install
elif command -v yarn &> /dev/null; then
    echo "Using yarn..."
    yarn install
else
    echo "Using npm..."
    npm install
fi

echo ""
echo "🧹 Cleaning Next.js cache..."
rm -rf .next

echo ""
echo "✅ UI fixes applied successfully!"
echo ""
echo "📝 Changes made:"
echo "   - Updated to Tailwind CSS v4"
echo "   - Fixed PostCSS configuration"
echo "   - Updated CSS to v4 syntax"
echo "   - Removed old config file"
echo ""
echo "🚀 To start the development server, run:"
echo "   cd dashboard && pnpm dev"
echo ""
echo "📖 For more details, see QUICK_FIX.md or FIX_UI_ISSUES.md"

