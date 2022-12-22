const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
)

// https://stackoverflow.com/questions/69394632/webpack-build-failing-with-err-ossl-evp-unsupported
// environment.config.merge({
//   output: {
//     hashFunction: "xxhash64"
//   }
// })

module.exports = environment
