const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

environment.plugins.append(
  'ForkTsCheckerWebpackPlugin',
  new ForkTsCheckerWebpackPlugin({
    typescript: {
      extensions: {
        vue: true,
      },
    },
    async: false,
  })
)

module.exports = environment
