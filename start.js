const WebSocket = require('ws');
const server = require('./src/server');
const port = 3000;
const log = (msg) => process.stdout.write(`${msg}\n`);

// Start REST server
server.listen(port, () => {
  log(`Server live at http://localhost:${port}/`);
});

// Run WebSocket server
const wss = new WebSocket.Server({port: 8000});

wss.on('connection', (ws) => {
  ws.on('message', (message) => {
    ws.send(message);
  });
});
