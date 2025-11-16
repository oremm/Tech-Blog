#!/usr/bin/env bash
set -euo pipefail

# Always run from this script's directory
cd "$(dirname "$0")"

echo "==> Step 1: Generate or update content (./ai-write.sh)"
if [ -x ./ai-write.sh ]; then
  ./ai-write.sh
else
  echo "WARN: ./ai-write.sh is not executable or missing; skipping content generation"
fi

echo "==> Step 2: Build site into public/ (./build.sh)"
if [ -x ./build.sh ]; then
  ./build.sh
else
  echo "ERROR: ./build.sh is not executable or missing"; exit 1
fi

echo "==> Step 3: Publish public/ to docs/ for GitHub Pages"
rm -rf docs
mkdir -p docs
rsync -a public/ docs/
touch docs/.nojekyll

echo "==> Step 4: Git commit & push"
git add -A
git commit -m "auto: write, build, publish" || echo "No changes to commit."
git push

echo "✅ Done: content generated, built, and pushed."
