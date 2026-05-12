

# フォントについて

"衡山毛筆フォント"をお借り。
サブセット化（必要な文字だけ抜き出してフォントを軽量化）して
元の.otfフォントから読み込みの早い.woff2フォントに変更する。

## 下記はubuntuでのフォントのサブセット化の場合

### 1. pipxインストール
sudo apt update
sudo apt install pipx

### 2. パスを通す
pipx ensurepath

### 3. fonttools と brotli をインストール
pipx install fonttools
pipx inject fonttools brotli

### 4. otfフォントをwoffフォントに変換
pyftsubset "KouzanMouhituFontOTF.otf" \
  --text-file="../src/data/miseData.json" \
  --flavor=woff2 \
  --layout-features='*' \
  --output-file="KouzanBrushFont_subset.woff2"



