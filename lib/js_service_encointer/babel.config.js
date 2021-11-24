module.exports = {
  env: {
    production: {
      presets: [['@babel/env', { modules: false }]],
      plugins: [
        ['@babel/plugin-transform-runtime', {
          regenerator: true
        }]
      ]
    },
    test: {
      presets: [['@babel/env', { modules: false }]],
      plugins: [
        ['@babel/plugin-transform-modules-commonjs', {
          'allowTopLevelThis': true
        }]
      ]
    }
  },
};
