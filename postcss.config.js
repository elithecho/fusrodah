module.exports = {
  plugins: {
    //'postcss-fontpath': { checkFiles: true, ie8Fix: true },
    'tailwindcss': 'src/tailwind.config.js',
    '@fullhuman/postcss-purgecss': process.env.NODE_ENV === 'production',
    'autoprefixer': {},
  },
}
