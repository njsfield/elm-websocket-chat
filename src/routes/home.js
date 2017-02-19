const fs = require('fs');
const path = require('path');

module.exports = (request, response) => {
  console.log('yes');
  fs.readFile(path.join(__dirname, '../../public/index.html'), (_, data) => {
    data = data.toString();
    data = data.replace(/{{socketport}}/, process.env.socketport);
    data = data.replace(/{{roomname}}/, process.env.roomname);
    response.writeHead(200, {'Content-type': 'text/html'});
    response.write(data);
    response.end();
  });
};
