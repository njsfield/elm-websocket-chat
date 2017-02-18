const fs = require('fs');
const path = require('path');

module.exports = (request, response) => {
  fs.readFile(path.join(__dirname, '../../public/index.html'), (_, data) => {
    response.writeHead(200, {'Content-type': 'text/html'});
    response.write(data);
    response.end();
  });
};
