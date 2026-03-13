import { NextResponse } from "next/server";

import { sendDeliveryEmail } from "@/lib/resend";

export const runtime = "nodejs";

export async function POST(request: Request) {
  const body = (await request.json().catch(() => null)) as
    | { email?: string; sessionId?: string }
    | null;
  const email = typeof body?.email === "string" ? body.email : "";
  const sessionId =
    typeof body?.sessionId === "string" ? body.sessionId : undefined;

  if (!email) {
    return NextResponse.json(
      { error: "A customer email address is required." },
      { status: 400 },
    );
  }

  try {
    const result = await sendDeliveryEmail({ to: email, sessionId });
    return NextResponse.json(result, { status: result.sent ? 200 : 202 });
  } catch (error) {
    return NextResponse.json(
      {
        error:
          error instanceof Error ? error.message : "Email delivery failed.",
      },
      { status: 502 },
    );
  }
}
