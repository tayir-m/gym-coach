class AppConfig {
  const AppConfig._();

  /// Cloudflare Workers proxy endpoint
  /// 默认指向已部署的 gym.qisqaisim.xyz；本地开发可用 --dart-define=PROXY_ENDPOINT=http://localhost:8787 覆盖
  static const String proxyEndpoint = String.fromEnvironment(
    'PROXY_ENDPOINT',
    defaultValue: 'https://gym.qisqaisim.xyz',
  );

  /// HMAC shared secret，与 proxy 的 `wrangler secret put HMAC_SECRET` 一致
  /// MVP 复用 dev 默认值；生产请用 `openssl rand -hex 32` 生成并通过 --dart-define 传入
  static const String hmacSecret = String.fromEnvironment(
    'HMAC_SECRET',
    defaultValue: 'dev-secret-change-me',
  );
}