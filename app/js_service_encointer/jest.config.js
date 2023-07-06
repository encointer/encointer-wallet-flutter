import { defaults } from 'jest-config';

export default {
  moduleFileExtensions: [...defaults.moduleFileExtensions, 'ts', 'tsx'],
  testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[jt]s?(x)'],
  moduleNameMapper: {},
  modulePathIgnorePatterns: [
    '<rootDir>/dist'
  ],
  transform: {},
  transformIgnorePatterns: [],
  verbose: true,
  setupFilesAfterEnv: ['<rootDir>/setup-jest.js'],
  transform: {
    "^.+\\.tsx?$": "ts-jest",
    "^.+\\.(js|jsx)$": "babel-jest"
  },
  transformIgnorePatterns: ['node_modules/(?!tslib|rxjs)'],
  resolver: "jest-ts-webcompat-resolver",
  moduleNameMapper:{"^rxjs$": "rxjs"}

};
