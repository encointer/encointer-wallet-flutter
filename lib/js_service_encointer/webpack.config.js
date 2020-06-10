const webpack = require("webpack");
const path = require("path");

const config = {
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "main.js"
  },
  resolve: {
    extensions: [ '.tsx', '.ts', '.js', '.jsx' ],
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        use: "babel-loader",
        exclude: /node_modules/
      },
      {
        test: /\.tsx?$/,
        loader: 'ts-loader',
        exclude: /node_modules/
      },
    ],
  }
};

module.exports = config;
