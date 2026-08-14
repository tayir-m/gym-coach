import { describe, it, expect } from 'vitest';
import { RateLimiter } from '../src/rate-limit';

describe('RateLimiter', () => {
  it('allows under quota', () => {
    const rl = new RateLimiter(3);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(false);
  });

  it('isolates keys', () => {
    const rl = new RateLimiter(1);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k2').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(false);
  });
});
