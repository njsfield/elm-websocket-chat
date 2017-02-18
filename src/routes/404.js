module.exports = (request, response) => {
  response.writeHead(404, {'Content-type': 'text/html'});
  response.end('Not Found');
};
