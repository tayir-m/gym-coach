export interface Env {
  QWEN_API_KEY: string;
  HMAC_SECRET: string;
  MONTHLY_BUDGET_YUAN: string;
}

export function getConfig(env: Env) {
  return {
    qwenApiKey: env.QWEN_API_KEY,
    hmacSecret: env.HMAC_SECRET,
    monthlyBudgetYuan: parseInt(env.MONTHLY_BUDGET_YUAN ?? '100', 10),
    qwenEndpoint: 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
    qwenModel: 'qwen-plus',
  };
}