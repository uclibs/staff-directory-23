// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const { generateWebpackConfig, merge } = require('shakapacker')
const webpack = require('webpack')

const webpackConfig = generateWebpackConfig()

// Single source of truth for NODE_ENV to avoid DefinePlugin "Conflicting values" warnings
const nodeEnv = process.env.NODE_ENV || process.env.RAILS_ENV || 'production'

// Disable node polyfills to fix Webpack 5 issues; unify NODE_ENV definitions
const customConfig = {
    resolve: {
        fallback: {
            fs: false,
            net: false,
            tls: false,
            dgram: false,
            child_process: false
        }
    },
    optimization: {
        nodeEnv: false
    },
    plugins: [
        new webpack.DefinePlugin({
            'process.env.NODE_ENV': JSON.stringify(nodeEnv),
            'import.meta.env.NODE_ENV': JSON.stringify(nodeEnv)
        })
    ]
}

module.exports = merge(webpackConfig, customConfig)