// One-shot shim so wrangler can run on Termux/Android arm64.
// workerd's npm package doesn't list "android arm64 LE" in its knownPackages
// table; Android arm64 is binary-compatible with linux arm64 for the workerd
// binary, so we just lie to it. Loaded via `node --require` before wrangler.
Object.defineProperty(process, 'platform', { value: 'linux', writable: false });