# gym-coach-proxy

Cloudflare Workers proxy for the 健身猫头鹰 app.

## Deploy

```bash
# Secrets (one-time per env):
wrangler secret put QWEN_API_KEY
wrangler secret put HMAC_SECRET

# Deploy:
wrangler deploy
```

After first deploy, add a custom domain in `wrangler.toml`:

```toml
routes = [
  { pattern = "<your-subdomain>/*", zone_id = "<zone-id>" }
]
```

Then create a CF-proxied DNS A record (any IP) for the subdomain.

## Smoke test

```bash
SECRET='<HMAC_SECRET value>'
TS=$(date +%s)
BODY='{"messages":[{"role":"user","content":"hi"}],"stream":true}'
SIG=$(printf '%s.%s' "$TS" "$BODY" | openssl dgst -sha256 -hmac "$SECRET" | awk '{print $2}')

curl -sN -X POST https://<your-subdomain>/v1/chat \
  -H "Content-Type: application/json" \
  -H "X-Timestamp: $TS" \
  -H "X-Signature: $SIG" \
  --data-binary "$BODY"
```

Expected: HTTP/2 200, `text/event-stream`, `data: {"delta":"..."}` chunks followed by `data: [DONE]`.

## Install (Termux / Android ARM64)

On Termux-Android-ARM64, `npm install` fails because the `workerd` and
`esbuild` packages have no prebuilt binary for that platform (`os: "android"`
not `"linux"`). Use `npm install --ignore-scripts` first, then:

```bash
npm install --ignore-scripts --save-dev --force @cloudflare/workerd-linux-arm64@1.20250718.0
npm install --ignore-scripts --save-dev --force @esbuild/linux-arm64@0.21.5
# nested wrangler copy needs matching esbuild version:
curl -sLO https://registry.npmjs.org/@esbuild/linux-arm64/-/linux-arm64-0.17.19.tgz
mkdir -p node_modules/wrangler/node_modules/@esbuild/linux-arm64
tar -xzf linux-arm64-0.17.19.tgz -C node_modules/wrangler/node_modules/@esbuild/linux-arm64 --strip-components=1
```

When running wrangler on Termux, also pre-load the platform shim (workerd's
knownPackages table doesn't include "android arm64 LE", so we lie and say
linux):

```bash
node --require ./scripts/patch-platform.cjs node_modules/.bin/wrangler <cmd>
```

`npm test` (`vitest run`) works on Termux out of the box — no workerd
needed.