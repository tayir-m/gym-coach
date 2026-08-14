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

  it('resets after window expires', () => {
    let t = 1_000_000;
    const rl = new RateLimiter(2, 1000, { now: () => t });
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').allowed).toBe(false);
    // Advance the clock past the window — the bucket should reset.
    t += 1500;
    expect(rl.consume('k1').allowed).toBe(true);
    expect(rl.consume('k1').remaining).toBe(0);
  });
});