import { productConfig } from "@/lib/config";

type DeliveryInput = {
  to: string;
  sessionId?: string;
};

export type DeliveryResult = {
  sent: boolean;
  mode: "demo" | "live";
  downloadUrl: string;
  detail: string;
  id?: string;
};

function renderDeliveryEmail(downloadUrl: string, sessionId?: string): string {
  const sessionMarkup = sessionId
    ? `<p style="margin: 0 0 12px;">Checkout session: <strong>${sessionId}</strong></p>`
    : "";

  return `
    <div style="font-family: Arial, sans-serif; max-width: 560px; margin: 0 auto; color: #102018;">
      <h1 style="font-size: 28px; margin-bottom: 12px;">Your Learn ML ebook is ready.</h1>
      ${sessionMarkup}
      <p style="line-height: 1.6; margin-bottom: 16px;">
        Thanks for purchasing the book. Use the button below to open your download.
      </p>
      <p style="margin-bottom: 20px;">
        <a href="${downloadUrl}" style="display: inline-block; padding: 12px 18px; background: #c7672a; color: #fff9f2; text-decoration: none; border-radius: 999px;">
          Open your ebook
        </a>
      </p>
      <p style="line-height: 1.6; color: #4d6356;">
        If the button fails, copy this URL into your browser:<br />
        <span>${downloadUrl}</span>
      </p>
    </div>
  `;
}

export async function sendDeliveryEmail(
  input: DeliveryInput,
): Promise<DeliveryResult> {
  const apiKey = process.env.RESEND_API_KEY;
  const from = process.env.RESEND_FROM_EMAIL;
  const downloadUrl = productConfig.deliveryUrl;

  if (!apiKey || !from) {
    return {
      sent: false,
      mode: "demo",
      downloadUrl,
      detail: "Resend credentials are missing; no email was sent.",
    };
  }

  const response = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      from,
      to: [input.to],
      subject: "Your Learn ML ebook",
      html: renderDeliveryEmail(downloadUrl, input.sessionId),
    }),
  });

  const payload = (await response.json().catch(() => ({}))) as {
    id?: string;
    message?: string;
  };

  if (!response.ok) {
    throw new Error(payload.message ?? `Resend returned ${response.status}.`);
  }

  return {
    sent: true,
    mode: "live",
    downloadUrl,
    detail: "Delivery email sent.",
    id: payload.id,
  };
}
