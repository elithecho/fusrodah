const purgecss = require('@fullhuman/postcss-purgecss')({
  content: [
    './**/**/*.slim',
  ],

  defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
});

module.exports = ({ webpack }) => {
  const production = webpack.mode === 'production'

  return {
    plugins: [
      require('autoprefixer'),
      require('tailwindcss')('./src/tailwind.config.js'),
      ...production
        ? [purgecss]
        : []
    ]
  }
}
