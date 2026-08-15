export interface Env {
  QWEN_API_KEY: string;
  HMAC_SECRET: string;
  MONTHLY_BUDGET_YUAN: string;
  QWEN_BASE_URL?: string;
  QWEN_MODEL?: string;
}

export function getConfig(env: Env) {
  const baseUrl =
    env.QWEN_BASE_URL ??
    'https://dashscope.aliyuncs.com/compatible-mode/v1';
  return {
    qwenApiKey: env.QWEN_API_KEY,
    hmacSecret: env.HMAC_SECRET,
    monthlyBudgetYuan: parseInt(env.MONTHLY_BUDGET_YUAN ?? '100', 10),
    qwenEndpoint: `${baseUrl}/chat/completions`,
    qwenModel: env.QWEN_MODEL ?? 'qwen-plus',
  };
}