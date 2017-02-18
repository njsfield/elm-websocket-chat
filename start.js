const WebSocket = require('ws');
const server = require('./server');
const restport = 3000;
const socketport = 8000;

// Run REST server
server.listen({port: restport});

// Run WebSocket server
const wss = new WebSocket.Server({ port: socketport });

wss.on('connection', (ws) => {
  ws.on('message', (message) => {
    console.log(message);
  });

  ws.send('something');
});
