import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { unstableRolldownAdapter, analyzer } from 'vite-bundle-analyzer';

export default defineConfig({
  plugins: [
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
    unstableRolldownAdapter(
      analyzer({
        analyzerMode: 'static',
        openAnalyzer: false,
        defaultSizes: 'gzip',
      }),
    ),
  ],
});
