import Stripe from "stripe";
import { NextResponse } from "next/server";

import { sendDeliveryEmail } from "@/lib/resend";
import { getStripeClient } from "@/lib/stripe";

export const runtime = "nodejs";

export async function POST(request: Request) {
  const stripe = getStripeClient();
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
  const signature = request.headers.get("stripe-signature");

  if (!stripe || !webhookSecret || !signature) {
    return NextResponse.json(
      {
        received: false,
        mode: "demo",
        detail: "Stripe webhook verification is not configured.",
      },
      { status: 202 },
    );
  }

  const payload = await request.text();
  let event: Stripe.Event;

  try {
    event = stripe.webhooks.constructEvent(payload, signature, webhookSecret);
  } catch (error) {
    return NextResponse.json(
      {
        error:
          error instanceof Error
            ? error.message
            : "Stripe webhook signature verification failed.",
      },
      { status: 400 },
    );
  }

  if (event.type === "checkout.session.completed") {
    const session = event.data.object as Stripe.Checkout.Session;
    const email = session.customer_details?.email ?? session.customer_email;

    if (email) {
      try {
        const result = await sendDeliveryEmail({
          to: email,
          sessionId: session.id,
        });

        return NextResponse.json({
          received: true,
          delivered: result.sent,
          mode: result.mode,
          sessionId: session.id,
        });
      } catch (error) {
        return NextResponse.json(
          {
            received: true,
            delivered: false,
            error:
              error instanceof Error ? error.message : "Delivery email failed.",
          },
          { status: 502 },
        );
      }
    }
  }

  return NextResponse.json({
    received: true,
    ignored: event.type,
  });
}
