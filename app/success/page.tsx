import Link from "next/link";
import { Suspense } from "react";

import SuccessClient from "./success-client";

function SuccessFallback() {
  return (
    <div className="surface stack">
      <p className="eyebrow">Purchase status</p>
      <h1>Checking checkout state.</h1>
      <p className="lede">
        The success screen reads the checkout query string on the client after
        hydration.
      </p>
      <div className="success-card">
        <h3>Preview download</h3>
        <p>You can still open the preview asset directly from here.</p>
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

export default function SuccessPage() {
  return (
    <main className="page">
      <section className="success-shell">
        <Suspense fallback={<SuccessFallback />}>
          <SuccessClient />
        </Suspense>
      </section>
    </main>
  );
}
