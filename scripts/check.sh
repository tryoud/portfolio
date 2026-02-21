#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== Astro config =="
grep -n "output" astro.config.mjs || true

echo "== Files =="
ls -la content/site.json src/pages/index.astro 1>/dev/null
ls -la src/components/sections 1>/dev/null

echo "== JSON valid =="
node -e "JSON.parse(require('fs').readFileSync('content/site.json','utf8')); console.log('site.json OK')"

echo "== Build =="
pnpm build >/dev/null
echo "build OK"

echo "== Git status =="
git status -sb
