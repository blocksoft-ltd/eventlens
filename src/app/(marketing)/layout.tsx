import { Header } from "@components/shared/layout/header"
import { Footer } from "@components/shared/layout/footer"
interface MarketingLayoutProps {
  children: React.ReactNode
}

export default async function MarketingLayout({
  children,
}: MarketingLayoutProps) {
  return (
    <div className="flex min-h-screen flex-col">
    <Header/>
      <main className="flex-1">{children}</main>
    <Footer />
    </div>
  )
}
