const http = require('https');

// Router
const router = require('./routes/index.js');

// Export Server
module.exports = http.createServer(router);
