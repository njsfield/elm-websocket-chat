const http = require('http');

module.exports = http.createServer((request, response) => {
  response.writeHead(200);
  response.end('HELLO WORLD');
});
