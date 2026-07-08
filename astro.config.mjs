// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  output: 'static',

  server: {
    port: process.env.PORT ? Number(process.env.PORT) : 4321,
  },

  vite: {
    plugins: [tailwindcss()],
  },
});