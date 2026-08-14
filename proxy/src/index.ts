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

const app = new Hono<{ Bindings: Env }>();

app.get('/health', (c) => c.json({ status: 'ok' }));

app.post('/v1/chat', async (c) => {
  const cfg = getConfig(c.env);

  const ts = c.req.header('X-Timestamp');
  const sig = c.req.header('X-Signature');
  if (!ts || !sig) return c.json({ error: 'missing auth headers' }, 401);

  const body = await c.req.text();
  const valid = await verifyHmac(cfg.hmacSecret, ts, body, sig);
  if (!valid) return c.json({ error: 'invalid signature' }, 401);

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
      try {
        for await (const chunk of client.streamChat({
          messages: payload.messages,
          temperature: payload.temperature ?? 0.7,
        })) {
          controller.enqueue(enc.encode(`data: ${JSON.stringify({ delta: chunk })}\n\n`));
        }
        controller.enqueue(enc.encode('data: [DONE]\n\n'));
      } catch (e) {
        controller.enqueue(enc.encode(`data: ${JSON.stringify({ error: String(e) })}\n\n`));
      } finally {
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
