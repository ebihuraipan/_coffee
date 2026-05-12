import { defineConfig } from 'vitest/config'
import vue from '@vitejs/plugin-vue'
import { VitePWA } from 'vite-plugin-pwa'
import CoffeeScript from 'coffeescript'
import type { Plugin } from 'vite'

const coffeePlugin: Plugin = {
  name: 'coffee',
  enforce: 'pre',
  transform(src, id) {
    if (id.endsWith('.coffee')) {
      const code = CoffeeScript.compile(src, { bare: true })
      return { code, map: null }
    }
    if (id.endsWith('.vue') && src.includes('lang="coffee"')) {
      const code = src.replace(
        /<script(\s[^>]*lang="coffee"[^>]*)>([\s\S]*?)<\/script>/g,
        (_, attrs: string, coffee: string) => {
          const js = CoffeeScript.compile(coffee.trim(), { bare: true })
          return `<script${attrs.replace(/\slang="coffee"/, '')}>\n${js}\n</script>`
        }
      )
      return { code, map: null }
    }
  }
}

export default defineConfig({
  test: {
    include: ['test/**/*.test.coffee']
  },
  plugins: [
    coffeePlugin,
    vue(),
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'Coffee Site',
        short_name: 'Coffee',
        description: 'Vue 3 + CoffeeScript PWA',
        start_url: '/',
        display: 'standalone',
        background_color: '#1a1a1a',
        theme_color: '#42b883',
        lang: 'ja',
        icons: [
          {
            src: '/icons/icon-192.png',
            sizes: '192x192',
            type: 'image/png',
            purpose: 'any maskable'
          },
          {
            src: '/icons/icon-512.png',
            sizes: '512x512',
            type: 'image/png',
            purpose: 'any maskable'
          }
        ]
      },
      workbox: {
        globPatterns: ['**/*.{js,css,html,ico,png,svg}']
      },
      devOptions: {
        enabled: true
      }
    })
  ],
  resolve: {
    extensions: ['.coffee', '.ts', '.js', '.vue', '.json']
  },
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    target: 'esnext'
  }
})
