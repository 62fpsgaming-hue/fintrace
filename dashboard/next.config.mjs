/** @type {import('next').NextConfig} */
const nextConfig = {
  typescript: {
    ignoreBuildErrors: true,
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
