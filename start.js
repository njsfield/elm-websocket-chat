const WebSocket = require('ws');
const server = require('./src/server');
const Room = require('./src/room');
const comms = require('./src/comms');
const port = 3000;
const log = (msg) => process.stdout.write(`${msg}\n`);

// Build New Room
const myRoom = new Room('coolroom');
// Start REST server
server.listen(port, () => {
  log(`Server live at http://localhost:${port}/`);
});

// Run WebSocket server
const socketserver = new WebSocket.Server({port: 8000});

// Handle messages
socketserver.on('connection', (ws) => {
  ws.on('message', (message) => {
    comms(myRoom, socketserver, ws, message);
  });
  ws.on('close', () => {
    comms(myRoom, socketserver, ws);
  });
});
