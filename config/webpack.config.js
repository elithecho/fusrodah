const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const PurgecssPlugin = require('purgecss-webpack-plugin');
const globAll = require('glob-all');

const TailwindExtractor = content => {
  return content.match(/[\w-/:]+(?<!:)/g) || [];
}

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({}),
    ]
  },
  entry: {
    '../src/app.js': glob.sync('./vendor/**/*.js').concat(['./src/app.js'])
  },
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, '../public')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        // Extract any SCSS content and minimize
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          { loader: 'css-loader', options: { importLoaders: 1 } },
          { loader: 'postcss-loader' },
          {
            loader: 'sass-loader',
            // options: {
            //   plugins: () => [autoprefixer()]
            // }
          }
        ]
      },
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../public/app.css' }),
    //new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
    ...(options.mode === 'production' ? [
      new PurgecssPlugin({
        paths: globAll.sync([
          path.join(__dirname, "../views/**/*.slim"),
        ]),
        extractors: [
          {
            extractor: TailwindExtractor,
            extensions: ["js", "slim"]
          }
        ]
      })
    ] : [])
  ]
});
