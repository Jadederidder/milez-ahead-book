#!/usr/bin/env bash
# Generates the bespoke WhatsApp header art that doesn't have a natural match in
# the trip set: the welcome greeting and the trip-extras card. Matches the house
# style of the existing wa-*.png (navy→teal gradient, gold MILEZ AHEAD wordmark,
# rounded icon tile, big headline + subtitle, diagonal teal accents). 1600×836.
set -euo pipefail
BOLD="/System/Library/Fonts/Supplemental/Arial Bold.ttf"
REG="/System/Library/Fonts/Supplemental/Arial.ttf"
NAVY='#262A4A'; TEAL='#01757E'; GOLD='#C9A24B'

base() { # $1=out  $2=headline  $3=subtitle
  magick -size 1600x836 -define gradient:angle=135 gradient:"$NAVY"-"$TEAL" \
    -draw "fill none stroke #9FE8DF stroke-opacity 0.15 stroke-width 26 line 1240,-40 1480,200" \
    -draw "fill none stroke #9FE8DF stroke-opacity 0.15 stroke-width 26 line 1340,-40 1630,250" \
    -fill "rgba(255,255,255,0.12)" -draw "roundrectangle 110,298 300,488 40,40" \
    -font "$BOLD" -fill "$GOLD" -pointsize 46 -kerning 10 -annotate +112+150 'MILEZ AHEAD' \
    -font "$BOLD" -fill white -pointsize 116 -kerning 0 -annotate +360+412 "$2" \
    -font "$REG"  -fill '#DCECEC' -pointsize 50 -annotate +364+486 "$3" \
    "$1.tmp.png"
}

# Welcome: a white steering-wheel glyph in the tile.
base wa-welcome 'WELCOME' 'Your executive ride, a tap away'
magick wa-welcome.tmp.png \
  -fill none -stroke white -strokewidth 11 -draw "circle 205,393 205,335" \
  -fill white -stroke none -draw "circle 205,393 205,375" \
  -fill none -stroke white -strokewidth 9 \
  -draw "line 205,358 205,378" -draw "line 188,402 170,414" -draw "line 222,402 240,414" \
  wa-welcome.png
rm -f wa-welcome.tmp.png

# Extras: a clean white plus in the tile.
base wa-extras 'TRIP EXTRAS' 'Add a little more to your ride'
magick wa-extras.tmp.png \
  -fill white -stroke none \
  -draw "roundrectangle 150,378 260,408 15,15" \
  -draw "roundrectangle 190,338 220,448 15,15" \
  wa-extras.png
rm -f wa-extras.tmp.png
echo "generated wa-welcome.png + wa-extras.png"
