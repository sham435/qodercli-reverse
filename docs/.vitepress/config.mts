import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'QoderCLI Reverse',
  description: 'Independent Go-based AI coding assistant CLI',
  lang: 'en-US',
  base: '/qodercli-reverse/',
  srcExclude: [
    'references/qoder-cli-documentation-index.md',
    'system-prompts-architecture.md',
    'system-prompt-builder-implementation.md',
  ],
  lastUpdated: true,
  vite: {
    vue: {
      template: {
        compilerOptions: {
          delimiters: ['[[', ']]'],
        },
      },
    },
  },
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'GitHub', link: 'https://github.com/sham435/qodercli-reverse' },
    ],
    search: { provider: 'local' },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/sham435/qodercli-reverse' },
    ],
    editLink: {
      pattern: 'https://github.com/sham435/qodercli-reverse/edit/main/docs/:path',
    },
  },
  head: [
    ['meta', { name: 'theme-color', content: '#3c8772' }],
  ],
})
