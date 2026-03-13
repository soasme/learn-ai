import type { Metadata } from "next";
import { Newsreader, Space_Grotesk } from "next/font/google";
import type { ReactNode } from "react";

import "./globals.css";

const display = Newsreader({
  subsets: ["latin"],
  variable: "--font-display",
});

const sans = Space_Grotesk({
  subsets: ["latin"],
  variable: "--font-sans",
});

export const metadata: Metadata = {
  title: "Learn ML by Implementing It",
  description:
    "A concise ebook that teaches machine learning through small runnable implementations.",
  metadataBase: new URL(
    process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000",
  ),
};

export default function RootLayout({
  children,
}: Readonly<{
  children: ReactNode;
}>) {
  return (
    <html lang="en" data-scroll-behavior="smooth">
      <body className={`${display.variable} ${sans.variable}`}>{children}</body>
    </html>
  );
}
