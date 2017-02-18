const WebSocket = require('ws');
const server = require('./src/server');
const restport = 3000;
const socketport = 8000;
const log = (msg) => process.stdout.write(`${msg}\n`);

// Start REST server
const liveserver = server.listen(restport, () => {
  log(`Server live at http://localhost:${restport}/`);
});

// Run WebSocket server
const wss = new WebSocket.Server({ port: socketport });

wss.on('connection', (ws) => {
  ws.on('message', (message) => {
    console.log(message);
  });

  ws.send('something');
});
