const http = require('http');

// Router
const router = require('./routes/index.js');

// Export Server
module.exports = http.createServer(router);
