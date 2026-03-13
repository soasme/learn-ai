# Learn ML

This repo now matches the project doc at a minimal first-pass level:

- a Next.js marketing and checkout app at the repository root
- a small Python ebook builder in `tools/bookbuilder.py`
- book source files in `book/`

## Quickstart

Install the web dependencies:

```bash
pnpm install
```

Run the website:

```bash
pnpm dev
```

Validate the sample chapter:

```bash
pnpm ebook:check
```

Build the book source bundle:

```bash
pnpm ebook:build
```

Run the web checks:

```bash
pnpm lint
pnpm build
```

If `typst` is installed locally, the builder also compiles `dist/learn-ml.pdf`.

## Environment

Copy `.env.example` to `.env.local` and set the keys you need.

- `STRIPE_SECRET_KEY` and `NEXT_PUBLIC_STRIPE_PRICE_ID` enable live checkout.
- `STRIPE_WEBHOOK_SECRET` enables verified Stripe webhook delivery.
- `RESEND_API_KEY` and `RESEND_FROM_EMAIL` enable live ebook email delivery.
- `BOOK_DELIVERY_URL` controls the link sent to customers.

Without those values, checkout and delivery stay in a demo-safe mode instead of failing.

## Package manager

This repo uses `pnpm` and commits `pnpm-lock.yaml`. Do not regenerate or commit
`package-lock.json`.
