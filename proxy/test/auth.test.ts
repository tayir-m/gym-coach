import { describe, it, expect } from 'vitest';
import { computeSignature, verifyHmac } from '../src/auth';

describe('HMAC auth', () => {
  it('verifies matching signature', async () => {
    const secret = 'test-secret';
    const ts = String(Math.floor(Date.now() / 1000));
    const body = '{"messages":[]}';
    const sig = await computeSignature(secret, ts, body);
    expect(await verifyHmac(secret, ts, body, sig)).toBe(true);
  });

  it('rejects mismatching body', async () => {
    const sig = await computeSignature('s', '1', 'a');
    expect(await verifyHmac('s', '1', 'b', sig)).toBe(false);
  });

  it('rejects stale timestamp (over 5 minutes)', async () => {
    const oldTs = String(Math.floor(Date.now() / 1000) - 600);
    const sig = await computeSignature('s', oldTs, 'b');
    expect(await verifyHmac('s', oldTs, 'b', sig)).toBe(false);
  });
});
