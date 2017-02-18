
const getIdentifier = (ws) => ws.upgradeReq.headers['sec-websocket-key'];

// Broadcast to everyone
const broadcast = (server, data) => {
  server.clients.forEach((client) => {
    client.send(data);
  });
};

// Main comms
module.exports = (room, server, ws, message) => {
  const endpoint = getIdentifier(ws);
  let name = '';
  if (!room.endpoints[endpoint]) {
    name = message;
    room.addEndpoint(endpoint);
    room.updateEndpointName(endpoint, name);
    broadcast(server, name + ' Joined the room');
  } else {
    name = room.getEndpointName(endpoint);
    broadcast(server, name + ' : ' + message);
  }
};
