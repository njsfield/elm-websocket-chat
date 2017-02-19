const https = require('https');

// Router
const router = require('./routes');

// Export Server
module.exports = https.createServer(router);
