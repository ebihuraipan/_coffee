---
name: review01
description: スキル indent-review と order-review でチェックするエージェント。
tools: Skill, Read, Bash
---

対象ファイルを指定されたスキルのみでチェックする。スキル外の作業は行わない

## 対象ファイル

- src/App.vue
- src/components/TategakiView.vue
- src/components/TategakiLine.vue
- src/components/TategakiDayFlag.vue

## 出力フォーマット

問題のある行だけを列挙する。問題がなければ「✅ インデント問題なし」と返す。

- 🔴 `行番号`: 内容（タブ/スペース混在など、CoffeeScriptで構文エラーになるもの）
- 🟡 `行番号`: 内容（動作はするが乱れているもの）
