#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_FONT="$SCRIPT_DIR/KouzanMouhituFontOTF.otf"
JSON_FILE="$SCRIPT_DIR/../src/data/miseData.json"
TMP_FILE="$SCRIPT_DIR/tmp.txt"
OUTPUT="$SCRIPT_DIR/../src/assets/fonts/KouzanBrushFont_subset.woff2"

> "$TMP_FILE"

cat "$JSON_FILE" >> "$TMP_FILE"
cat "$SCRIPT_DIR/../src/components/dialog/Technology.vue" >> "$TMP_FILE"
cat "$SCRIPT_DIR/../src/components/dialog/Warning.vue" >> "$TMP_FILE"
cat "$SCRIPT_DIR/../src/components/TategakiDayFlag.vue" >> "$TMP_FILE"
cat "$SCRIPT_DIR/../src/components/TategakiLine.vue" >> "$TMP_FILE"
cat "$SCRIPT_DIR/../src/components/TategakiView.vue" >> "$TMP_FILE"
echo "テキスト抽出完了: $TMP_FILE"

pyftsubset "$SRC_FONT" \
  --text-file="$TMP_FILE" \
  --flavor=woff2 \
  --layout-features='*' \
  --output-file="$OUTPUT"

echo "生成完了: $OUTPUT"
> "$TMP_FILE"
