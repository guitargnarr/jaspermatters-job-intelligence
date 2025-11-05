/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./**/*.{html,js}",
  ],
  theme: {
    extend: {
      colors: {
        // jaspermatters minimal tech palette
        'jasper-slate': '#0f172a',        // Primary: Serious tech
        'jasper-slate-light': '#1e293b',
        'jasper-slate-lighter': '#334155',
        'jasper-electric': '#3b82f6',     // Secondary: Innovation
        'jasper-electric-light': '#60a5fa',
        'jasper-purple': '#8b5cf6',       // Accent: Creativity (keeping current!)
        'jasper-purple-light': '#a78bfa',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif'],
        mono: ['JetBrains Mono', 'Menlo', 'Monaco', 'Courier New', 'monospace'],
      },
      boxShadow: {
        'glow': '0 0 20px rgba(59, 130, 246, 0.3)',
        'glow-purple': '0 0 20px rgba(139, 92, 246, 0.3)',
      },
    },
  },
  plugins: [],
}
