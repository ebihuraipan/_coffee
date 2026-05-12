#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_FONT="$SCRIPT_DIR/KouzanMouhituFontOTF.otf"
TEXT_FILE="$SCRIPT_DIR/../src/data/miseData.json"
OUTPUT="$SCRIPT_DIR/../src/assets/fonts/KouzanBrushFont_subset.woff2"

pyftsubset "$SRC_FONT" \
  --text-file="$TEXT_FILE" \
  --flavor=woff2 \
  --layout-features='*' \
  --output-file="$OUTPUT"

echo "生成完了: $OUTPUT"
