const config = require('./config/jest.cjs');

module.exports = {
  ...config,
  moduleNameMapper: {
    '@encointer/node-api(.*)$': '<rootDir>/../../../encointer-js/packages/node-api/src/$1',
    '@encointer/util(.*)$': '<rootDir>../../../encointer-js/packages/util/src/$1',
    '@encointer/types(.*)$': '<rootDir>../../../encointer-js/packages/types/src/$1',
    '@encointer/worker-api(.*)$': '<rootDir>/../../../encointer-js/packages/worker-api/src/$1'
  },
  modulePathIgnorePatterns: [
    '<rootDir>/dist'
  ],
  // transform esm `@polkadot`, `@encointer` and `@babels` esm modules such that jest understands them.
  transformIgnorePatterns: ['/node_modules/(?!@polkadot|@encointer|@babel/runtime/helpers/esm/)']
};
