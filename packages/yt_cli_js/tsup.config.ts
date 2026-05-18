import { defineConfig } from 'tsup';

export default defineConfig({
  entry: { cli: 'src/cli.ts' },
  format: ['esm'],
  platform: 'node',
  target: 'node18',
  dts: false,
  sourcemap: true,
  clean: true,
  external: ['commander'],
  banner: {
    js: '#!/usr/bin/env node',
  },
});
