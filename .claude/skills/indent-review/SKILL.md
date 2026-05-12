---
name: indent-review
description: インデントだけをチェックするスキル。「インデント確認して」「スペースがおかしい」など、字下げの乱れを調べたいときに使う。
tools:  Read, Bash
---

## 概要

指定されたファイルのインデントと無駄な行末の空白文字をチェックする。

## 手順

1. `<script lang="coffee">` を含む Vue SFC は `coffeelint` でチェックする
   ```bash
   sed -n '/<script/,/<\/script>/p' <ファイルパス> | sed '1d;$d' | bunx coffeelint --stdin -f coffeelint.json
   ```
   ※ VueSFC全体を渡すとテンプレート・スタイルをCoffeeScriptとして誤解析するため、scriptブロックのみ抽出する
2. `coffeelint` の結果に加え、テンプレート・スタイルセクションはgrepでスペース混在を確認する
   ```bash
   grep -Pn "^ " <ファイルパス>
   ```

## チェック観点

- インデントは基本タブのみ
- スペースがインデントに混在していないか
- `coffeelint` のエラー・警告はすべて報告する

## 出力フォーマット

問題のある行だけを列挙する。問題がなければ「✅ インデント問題なし」と返す。

- 🔴 `行番号`: 内容（タブ/スペース混在など、CoffeeScriptで構文エラーになるもの）
- 🟡 `行番号`: 内容（動作はするが乱れているもの）



