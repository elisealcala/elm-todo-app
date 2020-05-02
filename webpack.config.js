const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');


module.exports = {
  entry: './public/index.js',
  resolve: {
    extensions: ['.js', '.elm']
  },
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: 'elm-webpack-loader',
            options: {
                verbose: true,
                debug: true
            }
          }
        ]
      },
    ]
  },
  devServer: {
    contentBase: path.join(__dirname, 'build'),
    historyApiFallback: true,
    host: '0.0.0.0',
    compress: true,
    hot: true,
    port: 3000,
    publicPath: '/',
  },
  devtool: 'source-map',
  output: {
    filename: '[name].bundle.js',
    publicPath: '/',
    path: path.resolve(__dirname, 'build'),
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),
  ],
}