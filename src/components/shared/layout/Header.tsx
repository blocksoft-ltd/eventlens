import Link from 'next/link'
import {MainNav} from "@components/shared/nav/main-nav";
import {marketingConfig} from "@lib/config/marketing";
import {cn} from "@lib/utils";
import {buttonVariants} from "@components/ui/button";

export function Header() {
  return (
    <header className="container z-40 bg-background">
        <div className="flex h-20 items-center justify-between py-6">
          <MainNav items={marketingConfig.mainNav} />
          <nav>
            <Link
              href="/login"
              className={cn(
                buttonVariants({ variant: "secondary", size: "sm" }),
                "px-4"
              )}
            >
              Login
            </Link>
          </nav>
        </div>
      </header>
  )
}
