"use client";

import Link from "next/link";
import { useSearchParams } from "next/navigation";

export default function SuccessClient() {
  const searchParams = useSearchParams();
  const sessionId = searchParams.get("session_id");
  const demoMode = searchParams.get("demo") === "1";

  return (
    <div className="surface stack">
      <p className="eyebrow">Purchase status</p>
      <h1>{demoMode ? "Demo checkout complete." : "Thanks for your order."}</h1>
      <p className="lede">
        {demoMode
          ? "The repo is still in safe demo mode, so no payment or email was sent."
          : "Stripe returned successfully. In production, the webhook route sends the book email automatically."}
      </p>

      <div className="success-card">
        <h3>Session reference</h3>
        <p>
          <span className="mono">{sessionId ?? "demo-session"}</span>
        </p>
      </div>

      <div className="success-card">
        <h3>Preview download</h3>
        <p>
          Until the full book asset is attached, the repo ships a static preview
          file so the delivery path has a concrete target.
        </p>
        <div className="form-actions">
          <a className="button button-secondary" href="/learn-ml-preview.txt">
            Open the preview file
          </a>
          <Link className="button button-primary" href="/checkout">
            Return to checkout
          </Link>
        </div>
      </div>
    </div>
  );
}
