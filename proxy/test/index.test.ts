import { describe, it, expect } from 'vitest';
import app from '../src/index';

describe('proxy /health', () => {
  it('returns ok', async () => {
    const env = {
      QWEN_API_KEY: 'test-key',
      HMAC_SECRET: 'test-secret',
      MONTHLY_BUDGET_YUAN: '100',
    };
    const res = await app.fetch(
      new Request('http://localhost/health'),
      env,
    );
    expect(res.status).toBe(200);
    const body = await res.json() as { status: string };
    expect(body.status).toBe('ok');
  });
});