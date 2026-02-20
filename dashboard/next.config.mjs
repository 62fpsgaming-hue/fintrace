/** @type {import('next').NextConfig} */
const nextConfig = {
  typescript: {
    ignoreBuildErrors: true,
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  images: {
    unoptimized: true,
    domains: ['jgtarpigzpcadrsdmfhm.supabase.co'],
  },
  // Optimize for Railway deployment
  output: 'standalone',
  reactStrictMode: true,
  swcMinify: true,
}

export default nextConfig
