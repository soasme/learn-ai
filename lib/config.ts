const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";
const currencyCode = (process.env.BOOK_CURRENCY ?? "usd").toLowerCase();

export const productConfig = {
  title: "Learn ML by Implementing It",
  subtitle: "Minimal runnable machine learning chapters from scratch.",
  priceCents: Number(process.env.BOOK_PRICE_CENTS ?? 2900),
  currencyCode,
  siteUrl,
  stripePriceId: process.env.NEXT_PUBLIC_STRIPE_PRICE_ID ?? "",
  deliveryUrl:
    process.env.BOOK_DELIVERY_URL ?? `${siteUrl}/learn-ml-preview.txt`,
};

export function formatPrice(cents: number, currency: string): string {
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: currency.toUpperCase(),
  }).format(cents / 100);
}

export function isStripeReady(): boolean {
  return Boolean(process.env.STRIPE_SECRET_KEY && productConfig.stripePriceId);
}

export function isResendReady(): boolean {
  return Boolean(process.env.RESEND_API_KEY && process.env.RESEND_FROM_EMAIL);
}
