module.exports = {
  presets: [
    [
      '@babel/env',
      {
        debug: true
      }
    ],
    ['@babel/preset-env', { targets: { node: 'current' } }],
  ]
};
