#!/usr/bin/env bash

mkdir $1
cd $1
npm init -y
echo '<div id="app"></div><script src="bundle.js"></script>' > index.html
echo '{"presets": ["env","react"]}' > .babelrc
cat <<EOF > index.js
import React from 'react'
import ReactDOM from 'react-dom'
ReactDOM.render(<p>Hello, $1!</p>,document.getElementById('root'))
EOF
cat <<EOF > webpack.config.js
module.exports = {
  entry: "./index.js",
  output: {
    filename: "bundle.js",
  },
  module: {
    loaders: [
      {
        test: /\.js|\.jsx/,
        exclude: /node_modules/,
        loader: "babel-loader",
      }
    ]
  }
};
EOF
yarn add -D webpack webpack-dev-server babel-cli babel-preset-react babel-preset-env babel-loader
yarn add react react-dom
