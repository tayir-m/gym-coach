export class RateLimiter {
  private readonly quota: number;
  private readonly buckets = new Map<string, number>();

  constructor(quota: number) {
    this.quota = quota;
  }

  consume(key: string): { allowed: boolean; remaining: number } {
    const used = this.buckets.get(key) ?? 0;
    if (used >= this.quota) {
      return { allowed: false, remaining: 0 };
    }
    this.buckets.set(key, used + 1);
    return { allowed: true, remaining: this.quota - used - 1 };
  }

  reset(key: string) {
    this.buckets.delete(key);
  }
}
