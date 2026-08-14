# gym-coach-proxy

Cloudflare Workers proxy for the 健身猫头鹰 app.

## Install (Termux / Android ARM64)

On Termux-Android-ARM64, `npm install` fails because the `workerd` package
(used by `wrangler`) has no prebuilt binary for that platform. Use
`npm install --ignore-scripts` instead. This skips the `workerd` postinstall
step but leaves `vitest` and all TypeScript deps intact, so `npm test`
continues to work. Note that `wrangler dev` / `wrangler deploy` will still
need a real Linux/macOS dev box to run.