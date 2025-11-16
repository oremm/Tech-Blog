#!/usr/bin/env bash
set -e

BASE_URL="https://oremm.github.io/Tech-Blog"
DEFAULT_DESC="Tech tips, home networking, and practical connectivity guides."
DEFAULT_IMG="$BASE_URL/media/default-og-image.jpg"

for file in docs/*.html; do
  [ -f "$file" ] || continue

  # Skip if we've already injected SEO block
  if grep -q "SEO + Social" "$file"; then
    echo "Skipping $file (SEO already present)"
    continue
  fi

  echo "Injecting SEO into: $file"

  # Grab the <title> content
  title=$(grep -m1 -oP '(?<=<title>).*?(?=</title>)' "$file" || true)
  [ -z "$title" ] && title="Tech Blog"

  slug=$(basename "$file")
  url="$BASE_URL/$slug"

  meta="  <!-- SEO + Social -->
  <meta name=\"description\" content=\"$DEFAULT_DESC\">
  <meta name=\"author\" content=\"Eric Wiseman\">

  <meta property=\"og:type\" content=\"article\">
  <meta property=\"og:title\" content=\"$title\">
  <meta property=\"og:description\" content=\"$DEFAULT_DESC\">
  <meta property=\"og:url\" content=\"$url\">
  <meta property=\"og:image\" content=\"$DEFAULT_IMG\">

  <meta name=\"twitter:card\" content=\"summary_large_image\">"

  # Insert the meta block right after the first <head> tag
  awk -v meta="$meta" '
    BEGIN { done=0 }
    {
      print
      if (!done && /<head[> ]/) {
        print meta
        done=1
      }
    }
  ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

done
