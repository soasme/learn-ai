import { NextResponse } from "next/server";

import { isStripeReady, productConfig } from "@/lib/config";
import { getStripeClient } from "@/lib/stripe";

export const runtime = "nodejs";

export async function POST() {
  if (!isStripeReady()) {
    return NextResponse.redirect(
      new URL("/success?demo=1", productConfig.siteUrl),
      { status: 303 },
    );
  }

  const stripe = getStripeClient();
  if (!stripe) {
    return NextResponse.json(
      { error: "Stripe is configured incorrectly." },
      { status: 500 },
    );
  }

  try {
    const session = await stripe.checkout.sessions.create({
      mode: "payment",
      billing_address_collection: "auto",
      customer_creation: "always",
      line_items: [
        {
          price: productConfig.stripePriceId,
          quantity: 1,
        },
      ],
      metadata: {
        product: "learn-ml-ebook",
      },
      success_url: `${productConfig.siteUrl}/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${productConfig.siteUrl}/checkout?canceled=1`,
    });

    if (!session.url) {
      return NextResponse.json(
        { error: "Stripe did not return a checkout URL." },
        { status: 500 },
      );
    }

    return NextResponse.redirect(session.url, { status: 303 });
  } catch (error) {
    return NextResponse.json(
      {
        error:
          error instanceof Error ? error.message : "Stripe checkout failed.",
      },
      { status: 500 },
    );
  }
}
