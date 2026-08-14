import { Hono } from 'hono';
import type { Env } from './config';
import { getConfig } from './config';
import { verifyHmac } from './auth';
import { RateLimiter } from './rate-limit';
import { QwenClient, ChatMessage } from './llm-client';

interface ChatRequestBody {
  messages: ChatMessage[];
  model?: string;
  stream?: boolean;
  temperature?: number;
}

const rl = new RateLimiter(1000);

// Naive in-memory monthly cost counter. Keyed by YYYY-MM. Resets when the
// calendar month rolls over. Sufficient for a single-worker MVP; a real
// production deploy needs persistent storage (KV/D1) and per-instance
// aggregation.
const usageByMonth = new Map<string, number>();

// MVP simplification: cost a flat 0.05 yuan (~5 cents) per completed chat
// request, regardless of token count. The proxy is signed/HMAC-gated so
// abuse is bounded; real token-based accounting can come with the polish
// pass when we have an actual usage endpoint to read from.
const ESTIMATED_COST_PER_REQUEST_YUAN = 0.05;

const MAX_BODY_BYTES = 64 * 1024;

const app = new Hono<{ Bindings: Env }>();

app.get('/health', (c) => c.json({ status: 'ok' }));

app.post('/v1/chat', async (c) => {
  const cfg = getConfig(c.env);

  const ts = c.req.header('X-Timestamp');
  const sig = c.req.header('X-Signature');
  if (!ts || !sig) return c.json({ error: 'missing auth headers' }, 401);

  const body = await c.req.text();
  if (body.length > MAX_BODY_BYTES) {
    return c.json({ error: 'payload too large' }, 413);
  }
  const valid = await verifyHmac(cfg.hmacSecret, ts, body, sig);
  if (!valid) return c.json({ error: 'invalid signature' }, 401);

  // Monthly budget guard. Configured in cents-of-yuan approximation (1 yuan =
  // 100 cents); the MVP cost model is a flat 0.05 yuan per successful request
  // so we multiply the configured budget by 100 to get a per-yuan budget.
  const monthKey = new Date().toISOString().slice(0, 7); // YYYY-MM
  const monthUsage = usageByMonth.get(monthKey) ?? 0;
  if (monthUsage >= cfg.monthlyBudgetYuan * 100) {
    return c.json({ error: 'monthly budget exhausted' }, 503);
  }

  const ip = c.req.header('CF-Connecting-IP') ?? 'unknown';
  const limit = rl.consume(ip);
  if (!limit.allowed) return c.json({ error: 'rate limited' }, 429);

  let payload: ChatRequestBody;
  try {
    payload = JSON.parse(body);
  } catch {
    return c.json({ error: 'invalid json' }, 400);
  }

  const client = new QwenClient(cfg.qwenApiKey, cfg.qwenModel, cfg.qwenEndpoint);

  const stream = new ReadableStream({
    async start(controller) {
      const enc = new TextEncoder();
      let succeeded = false;
      try {
        for await (const chunk of client.streamChat({
          messages: payload.messages,
          temperature: payload.temperature ?? 0.7,
        })) {
          controller.enqueue(enc.encode(`data: ${JSON.stringify({ delta: chunk })}\n\n`));
        }
        controller.enqueue(enc.encode('data: [DONE]\n\n'));
        succeeded = true;
      } catch (e) {
        controller.enqueue(enc.encode(`data: ${JSON.stringify({ error: String(e) })}\n\n`));
      } finally {
        if (succeeded) {
          // Increment after the stream completes so we only count successful
          // requests against the monthly budget. Value is in cents-of-yuan
          // (ESTIMATED_COST_PER_REQUEST_YUAN * 100).
          const prev = usageByMonth.get(monthKey) ?? 0;
          usageByMonth.set(monthKey, prev + ESTIMATED_COST_PER_REQUEST_YUAN * 100);
        }
        controller.close();
      }
    },
  });

  return new Response(stream, {
    headers: {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
    },
  });
});

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    return app.fetch(request, env);
  },
};