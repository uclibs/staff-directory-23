const { environment } = require('@rails/webpacker');

process.env.NODE_OPTIONS = '--openssl-legacy-provider';
// Fully disable node polyfills to fix Webpack 5 issues
environment.config.merge({
    resolve: {
        fallback: {
            fs: false,
            net: false,
            tls: false,
            dgram: false,
            child_process: false
        }
    },
    node: false
});

module.exports = environment;
