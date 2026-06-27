#!/usr/bin/env bash
# Co-brands the Milez Ahead WhatsApp header art for a partner program (MUA).
# Overlays an elegant gold "MUA · MEMBER BENEFIT" lockup on the top-right of each
# existing wa-*.png so members of an MUA program see a co-branded card while the
# house style (navy→teal, gold MILEZ AHEAD wordmark) stays intact.
#
# Drop-in for the real logo: replace the text annotate with a `magick composite
# mua-logo.png` once MUA supplies a transparent PNG mark, no other change needed.
set -euo pipefail
BOLD="/System/Library/Fonts/Supplemental/Arial Bold.ttf"
REG="/System/Library/Fonts/Supplemental/Arial.ttf"
GOLD='#C9A24B'
OUT=mua

cobrand() { # $1 = source wa-*.png filename
  local src="$1"
  magick "$src" \
    -fill "rgba(255,255,255,0.10)" -stroke "$GOLD" -strokewidth 3 \
    -draw "roundrectangle 1132,60 1520,176 22,22" \
    -stroke none \
    -font "$BOLD" -fill "$GOLD" -pointsize 52 -kerning 6 -annotate +1176+128 'MUA' \
    -font "$REG"  -fill '#EAF3F3' -pointsize 23 -kerning 2 -annotate +1176+158 'MEMBER BENEFIT' \
    "$OUT/$src"
}

for f in wa-assigned.png wa-enroute.png wa-arrived.png wa-complete.png wa-booked.png; do
  cobrand "$f"
  echo "co-branded -> $OUT/$f"
done
echo "done"
