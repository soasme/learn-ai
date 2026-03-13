import Link from "next/link";

import { getBookManifest } from "@/lib/book";
import {
  formatPrice,
  isResendReady,
  isStripeReady,
  productConfig,
} from "@/lib/config";

const features = [
  {
    title: "One-file chapters",
    body: "Each idea lands in a single runnable Python file so the reader can hold the whole system in their head.",
  },
  {
    title: "Faithful simplification",
    body: "The code stays small without replacing the core algorithm with toy shortcuts.",
  },
  {
    title: "Book-first tooling",
    body: "The builder validates code, assembles Typst source, and keeps chapter content shippable.",
  },
];

export default async function HomePage() {
  const manifest = await getBookManifest();
  const price = formatPrice(
    productConfig.priceCents,
    productConfig.currencyCode,
  );

  return (
    <main className="page">
      <section className="hero">
        <div>
          <p className="eyebrow">Ebook + runnable code</p>
          <h1>Learn modern ML by opening the machine.</h1>
          <p className="lede">
            {manifest.subtitle} The site sells the book, the builder verifies
            the code, and the first chapter already runs end to end.
          </p>
          <div className="form-actions">
            <Link className="button button-primary" href="/checkout">
              Buy for {price}
            </Link>
            <a className="button button-secondary" href="/learn-ml-preview.txt">
              Read the preview
            </a>
          </div>
          <p className="fine-print">
            Checkout mode: {isStripeReady() ? "live-ready" : "demo-safe"}.
            Delivery mode: {isResendReady() ? "live email-ready" : "demo-safe"}.
          </p>
        </div>

        <aside className="hero-panel">
          <div className="surface">
            <span className="badge">Current contents</span>
            <ul className="chapter-list">
              {manifest.chapters.map((chapter) => (
                <li key={chapter.slug}>
                  <h3>{chapter.title}</h3>
                  <p className="muted">{chapter.summary}</p>
                </li>
              ))}
            </ul>
          </div>
        </aside>
      </section>

      <section className="section">
        <div className="stat-grid">
          <div className="stat">
            <strong>1</strong>
            <p>sample chapter already wired into the builder and site</p>
          </div>
          <div className="stat">
            <strong>100-300</strong>
            <p>lines is the target size for most chapter implementations</p>
          </div>
          <div className="stat">
            <strong>0</strong>
            <p>hidden helper layers between the reader and the core algorithm</p>
          </div>
        </div>
      </section>

      <section className="section">
        <div className="section-heading">
          <p className="eyebrow">Why this format works</p>
          <h2>Readers can read the idea, run the file, and change it safely.</h2>
        </div>
        <div className="card-grid">
          {features.map((feature) => (
            <article className="feature-card" key={feature.title}>
              <h3>{feature.title}</h3>
              <p>{feature.body}</p>
            </article>
          ))}
        </div>
      </section>

      <section className="section">
        <div className="section-heading">
          <p className="eyebrow">Repository shape</p>
          <h2>The docs are now grounded in concrete code.</h2>
        </div>
        <div className="chapter-grid">
          <article className="chapter-card">
            <h3>Website</h3>
            <p>
              The root Next.js app covers the landing page, checkout entrypoint,
              success screen, Stripe session creation, and webhook-based delivery
              hooks.
            </p>
          </article>
          <article className="chapter-card">
            <h3>CLI builder</h3>
            <p>
              <span className="mono">python3 -m tools.bookbuilder build</span>{" "}
              validates each chapter, writes a Typst bundle, and compiles a PDF
              when Typst is installed.
            </p>
          </article>
          <article className="chapter-card">
            <h3>Ebook source</h3>
            <p>
              Book metadata, chapter text, and runnable code now live under{" "}
              <span className="mono">book/</span>.
            </p>
          </article>
        </div>
      </section>
    </main>
  );
}
