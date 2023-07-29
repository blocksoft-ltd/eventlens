import Footer from '@components/shared/Footer'
import Header from '@components/shared/Header'
import config from '@lib/config'
import {ReactChildren} from '@lib/types'
import {Metadata} from 'next'

import '../styles/globals.css'

/**
 * Default metadata.
 *
 * @see https://nextjs.org/docs/app/api-reference/file-conventions/metadata
 */
export const metadata: Metadata = {
  title: config.siteName,
  description: config.siteDescription
}

/**
 * The homepage root layout.
 *
 * @see https://nextjs.org/docs/app/api-reference/file-conventions/layout
 */
export default function RootLayout({children}: ReactChildren) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta content="IE=edge" httpEquiv="X-UA-Compatible" />
        <meta
            content="width=device-width, initial-scale=1"
            name="viewport"
        />
        <meta content="/favicons/browserconfig.xml" name="msapplication-config" />
        <meta content="yes" name="apple-mobile-web-app-capable" />
        <meta content="default" name="apple-mobile-web-app-status-bar-style" />
        <meta content="summary_large_image" name="twitter:card" />
        <meta content="@vercel" name="twitter:site" />
        <meta content="@vercel" name="twitter:creator" />
        <meta content={config.siteName} name="twitter:title" />
        <meta content={config.siteDescription} name="twitter:description" />
        <meta content="/favicons/android-chrome-192x192.png" name="twitter:image" />
        <meta content="/favicons/android-chrome-192x192.png" property="og:image" />
        <meta content={config.siteName} property="og:site_name" />
        <meta content={config.siteName} property="og:title" />
        <meta content={config.siteDescription} property="og:description" />
        <meta content="website" property="og:type" />
        <meta content="https://vercel.com" property="og:url" />
        <meta content="/favicons/android-chrome-192x192.png" property="og:image" />
        <meta content="en_US" property="og:locale" />
      </head>
      <body>
        <Header />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  )
}
