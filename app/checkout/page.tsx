import Link from "next/link";

import { getBookManifest } from "@/lib/book";
import { formatPrice, isStripeReady, productConfig } from "@/lib/config";

export default async function CheckoutPage() {
  const manifest = await getBookManifest();
  const price = formatPrice(
    productConfig.priceCents,
    productConfig.currencyCode,
  );
  const liveMode = isStripeReady();

  return (
    <main className="page">
      <section className="checkout-shell">
        <div className="surface stack">
          <p className="eyebrow">Checkout</p>
          <h1>{manifest.title}</h1>
          <p className="lede">
            {liveMode
              ? "Stripe is configured. The button below creates a real checkout session."
              : "Stripe keys are missing. The button below uses a demo redirect so the flow stays testable."}
          </p>

          <dl className="checkout-meta">
            <div>
              <dt>Price</dt>
              <dd>{price}</dd>
            </div>
            <div>
              <dt>Delivery</dt>
              <dd>Email via Resend webhook flow</dd>
            </div>
          </dl>

          <form action="/api/checkout" method="post">
            <button className="button button-primary" type="submit">
              {liveMode ? `Continue to Stripe for ${price}` : `Run demo checkout for ${price}`}
            </button>
          </form>

          <div className="checkout-grid">
            <article className="checkout-card">
              <h3>After payment</h3>
              <p>
                Stripe redirects the buyer to the success page with the checkout
                session id.
              </p>
            </article>
            <article className="checkout-card">
              <h3>Delivery</h3>
              <p>
                A Stripe webhook can trigger the delivery email automatically
                once the payment is confirmed.
              </p>
            </article>
            <article className="checkout-card">
              <h3>Fallback</h3>
              <p>
                The repo also exposes an internal delivery endpoint for testing
                the Resend email path directly.
              </p>
            </article>
          </div>

          <p className="notice">
            Current mode: <span className="mono">{liveMode ? "live" : "demo"}</span>
          </p>

          <Link className="link-line" href="/">
            Back to the landing page
          </Link>
        </div>
      </section>
    </main>
  );
}
