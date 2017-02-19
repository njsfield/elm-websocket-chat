const https = require('https');

// Router
const router = require('./routes/index.js');

// Export Server
module.exports = https.createServer(router);
