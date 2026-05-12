# CLAUDE.md

日本語で回答。

## プロジェクト概要

このプロジェクトは静的サイト作成です。但しVueやCoffeeScriptでフロントを構成します。PWAも配置します。
縦書き、横スクロール、デフォルト右寄せ、の特殊な画面構成にします。

## 開発コマンド

パッケージマネージャ・ランナーは `bun` を使用。

### セットアップ

```bash
curl -fsSL https://bun.com/install | bash
bun install
```

### ビルド

```bash
bun run build   # dist/ に静的ファイルを生成
```

### 起動

```bash
bun run dev     # 開発サーバー (http://localhost:5173)
bun run preview # ビルド済みファイルのプレビュー
```

## アーキテクチャ

- **ビルド**: Vite 6（`bun run` 経由）
- **UI**: Vue 3 SFC（`<script lang="coffee">` で CoffeeScript を記述）
- **スクリプト**: CoffeeScript 2（`.coffee` ファイルおよび Vue SFC 内）
- **PWA**: vite-plugin-pwa（Workbox によるキャッシュ、manifest 自動生成）
- **出力**: `dist/` 以下の完全な静的ファイル群

### CoffeeScript の扱い

`vite.config.ts` に `enforce: 'pre'` のカスタムプラグインを定義しており、
`@vitejs/plugin-vue` より先に `.vue` ファイル内の `<script lang="coffee">` を JS に変換する。
スタンドアロンの `.coffee` ファイルも同プラグインでトランスパイルされる。
