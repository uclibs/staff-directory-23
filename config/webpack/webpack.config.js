// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const { generateWebpackConfig, merge } = require('shakapacker')

const webpackConfig = generateWebpackConfig()

// Disable node polyfills to fix Webpack 5 issues
const customConfig = {
    resolve: {
        fallback: {
            fs: false,
            net: false,
            tls: false,
            dgram: false,
            child_process: false
        }
    }
}

module.exports = merge(webpackConfig, customConfig)