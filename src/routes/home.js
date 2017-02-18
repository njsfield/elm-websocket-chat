// Access global room object for this example
// const myRoom = require('../../myroom.js');

const fs = require('fs');
const path = require('path');
// const log = (msg) => process.stdout.write(`${msg}\n`);

// Home request
module.exports = (request, response) => {
  fs.readFile(path.join(__dirname, '../../public/index.html'), (_, data) => {
      // Inject roomName + endpointId
      // data = data.toString();
      // data = data.replace(/{{roomname}}/g, roomName);
      // data = data.replace(/{{endpointid}}/g, endpointId);

      // Respond
    response.writeHead(200, {'Content-type': 'text/html'});
    response.write(data);
    response.end();
  });
};
