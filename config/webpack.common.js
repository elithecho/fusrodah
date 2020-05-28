const paths = require('./paths')
const ManifestPlugin = require('webpack-manifest-plugin')
const { CleanWebpackPlugin } = require('clean-webpack-plugin')

module.exports = {
  entry: [paths.src + '/app.js'],
  output: {
    path: paths.build,
    filename: '[name].[hash].js',
    publicPath: '/',
  },
  resolve: {
    alias: {
      '@': paths.src,
      //svelte: path.resolve('node_modules', 'svelte')
    },
    //extensions: ['.mjs', '.js', '.svelte'],
    //mainFields: ['svelte', 'browser', 'module', 'main']
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: ['babel-loader']
      },
      {
        // Extract any SCSS content and minimize
        test: /\.(css|scss)$/,
        use: [
          /**
           * MiniCssExtractPlugin doesn't support HMR.
           * For developing, use 'style-loader' instead.
           * */
          'style-loader',
          { loader: 'css-loader', options: { sourceMap: true, importLoaders: 1 } },
          { loader: 'postcss-loader', options: { sourceMap: true } },
          { loader: 'sass-loader', options: { sourceMap: true } },
        ]
      },
    ]
  },
  plugins: [
    new CleanWebpackPlugin(),
    new ManifestPlugin(),
  ],
}
