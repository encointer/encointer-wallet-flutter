const path = require('path');
const webpack = require('webpack');

function createWebpack () {
  return [
    {
      entry: {
        entry: './src/index.js'
      },
      mode: 'production',
      module: {
        rules: [
          {
            include: /node_modules/,
            test: /\.mjs$/,
            type: 'javascript/auto'
          },
          {
            exclude: /(node_modules)/,
            test: /\.(js|mjs|ts|tsx)$/,
            use: [
              require.resolve('thread-loader'),
              {
                loader: require.resolve('babel-loader'),
                options: require('@polkadot/dev/config/babel-config-webpack.cjs')
              }
            ]
          }
        ]
      },
      node: {
        __dirname: false,
        __filename: false
      },
      output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'main.js'
      },
      plugins: [
        new webpack.ProvidePlugin({
          Buffer: ['buffer', 'Buffer'],
          process: 'process/browser.js'
        })
      ],
      resolve: {
        extensions: ['.js', '.jsx', '.json', '.mjs', '.ts', '.tsx'],
        fallback: {
          crypto: require.resolve('crypto-browserify'),
          path: require.resolve('path-browserify'),
          stream: require.resolve('stream-browserify')
        }
      },
      target: ['web']
    }
  ];
}

module.exports = createWebpack();
