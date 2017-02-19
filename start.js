const WebSocketServer = require('ws').Server;
const server = require('./src/server');
const Room = require('./src/room');
const comms = require('./src/comms');
const port = process.env.PORT || 3000;
const log = (msg) => process.stdout.write(`${msg}\n`);
const env = require('env2');

// Install environment variables
env('./config.env');

// Build New Room
const myRoom = new Room(process.env.roomname);
// Start REST server
server.listen(port, () => {
  log(`Server live at http://localhost:${port}/`);
});

// Run WebSocket server
const socketserver = new WebSocketServer({server: server});

// Handle messages
socketserver.on('connection', (ws) => {
  ws.on('message', (message) => {
    comms(myRoom, socketserver, ws, message);
  });
  ws.on('close', () => {
    comms(myRoom, socketserver, ws);
  });
});
