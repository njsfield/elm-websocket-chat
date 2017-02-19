
const getIdentifier = (ws) => ws.upgradeReq.headers['sec-websocket-key'];

// Broadcast to everyone
const broadcast = (server, data) => {
  server.clients.forEach((client) => {
    client.send(data);
  });
};

// Add endpoint
const addEndpoint = (endpoint, name, server, room) => {
  room.addEndpoint(endpoint);
  room.updateEndpointName(endpoint, name);
  broadcast(server, name ? name + ' Joined the room' : 'A spy left the room');
};

// Remove endpoint
const removeEndpoint = (endpoint, server, room) => {
  let name = room.getEndpointName(endpoint);
  room.removeEndpoint(endpoint);
  broadcast(server, name + ' Left the room');
};

// New Message
const newMessage = (endpoint, server, room, message) => {
  let name = room.getEndpointName(endpoint);
  broadcast(server, name + ' : ' + message);
};

// Main comms
module.exports = (room, server, ws, message) => {
  const endpoint = getIdentifier(ws);
  if (!room.endpoints[endpoint]) {
    addEndpoint(endpoint, message, server, room);
  } else if (!message) {
    removeEndpoint(endpoint, server, room);
  } else {
    newMessage(endpoint, server, room, message);
  }
};
