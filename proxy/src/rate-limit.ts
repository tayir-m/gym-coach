export interface RateLimiterOptions {
  now?: () => number;
}

interface Bucket {
  used: number;
  resetAt: number;
}

export class RateLimiter {
  private readonly quota: number;
  private readonly windowMs: number;
  private readonly buckets = new Map<string, Bucket>();
  private readonly now: () => number;

  constructor(quota: number, windowMs: number = 24 * 60 * 60 * 1000, opts: RateLimiterOptions = {}) {
    this.quota = quota;
    this.windowMs = windowMs;
    this.now = opts.now ?? (() => Date.now());
  }

  consume(key: string): { allowed: boolean; remaining: number } {
    const t = this.now();
    const bucket = this.buckets.get(key);
    if (bucket === undefined || t > bucket.resetAt) {
      this.buckets.set(key, { used: 1, resetAt: t + this.windowMs });
      return { allowed: true, remaining: this.quota - 1 };
    }
    if (bucket.used >= this.quota) {
      return { allowed: false, remaining: 0 };
    }
    bucket.used += 1;
    return { allowed: true, remaining: this.quota - bucket.used };
  }

  reset(key: string) {
    this.buckets.delete(key);
  }
}