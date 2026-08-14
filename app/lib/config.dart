class AppConfig {
  const AppConfig._();

  /// Cloudflare Workers proxy endpoint
  /// 部署后填入实际地址，形如 https://gym-coach.<subdomain>.workers.dev
  static const String proxyEndpoint = String.fromEnvironment(
    'PROXY_ENDPOINT',
    defaultValue: 'http://localhost:8787',
  );

  /// HMAC shared secret，与 proxy/wrangler.toml 中的值一致
  static const String hmacSecret = String.fromEnvironment(
    'HMAC_SECRET',
    defaultValue: 'dev-secret-change-me',
  );
}