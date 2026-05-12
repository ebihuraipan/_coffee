---
# スキルの識別名（kebab-case）。`/skill-name` の形で呼び出す。
name: order-review

description: ソースの記入順だけをチェックするスキル。主にvueファイル。

# 使用するツールをカンマ区切りで列挙する。
# 目安:
#   ファイル読み書き → Read, Write
#   シェル実行       → Bash
#   Web検索          → WebSearch, WebFetch
#   コード調査       → Read, Bash
tools: Read, Bash
---


指定された `.vue` ファイルの宣言順序のみをチェックする。

## 手順

cat, fdfind, rg, のコマンドで調査


## チェック観点

### `<script>` 内のimport順
1. Vueコア（`vue` からのimport）
2. 外部ライブラリ（`dayjs` など）
3. 内部ユーティリティ（`../utils/...`）
4. 内部コンポーネント（`./...`）

### `export default` 内の項目順
1. `name`
2. `components`
3. `props`
4. `emits`
5. `setup`

### `setup` 内の記述順
1. `ref` / `reactive` の宣言
2. ヘルパー関数の定義
3. `onMounted` などライフサイクルフック
4. `return {}` （必ず末尾）

## 出力フォーマット

順番が乱れている箇所だけを示す。問題がなければ「✅ 宣言順問題なし」と返す。

- 🟡 `項目名`: 期待する位置 → 実際の位置
