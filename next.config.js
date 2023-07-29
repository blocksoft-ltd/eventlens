const path = require('path')

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  poweredByHeader: false,
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'nextjswp.dreamhosters.com'
      },
      {
        protocol: 'https',
        hostname: '**.gravatar.com'
      }
    ]
  },
   sassOptions: {
    includePaths: [path.join(__dirname, 'styles')],
  },
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'Strict-Transport-Security',
            value: `max-age=3600; includeSubDomains; preload`,
          },
          {
            key: 'X-XSS-Protection',
            value: '1; mode=block',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'X-Download-Options',
            value: 'noopen',
          },
          {
            key: 'X-Robots-Tag',
            value: 'noarchive,nofollow',
          },
        ],
      },
    ]
  },
}


module.exports = nextConfig
