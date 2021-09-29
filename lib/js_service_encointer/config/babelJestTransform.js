// Apparently, we need to have this in a separate file to satisfy jest.
//
// https://babeljs.io/docs/en/config-files#jest

const babelJest = require('babel-jest');

module.exports = babelJest.default.createTransformer(
  { rootMode: 'upward' }
);
