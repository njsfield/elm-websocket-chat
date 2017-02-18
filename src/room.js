// Global room class
function Room (roomname) {
  this.roomname = roomname;
  this.endpoints = {};
}

// Add Endpoint
Room.prototype.addEndpoint = function (endpoint) {
  this.endpoints[endpoint] = {
    name: ''
  };
};

// Update Endpoint Name
Room.prototype.updateEndpointName = function (endpoint, name) {
  this.endpoints[endpoint].name = name;
};

// Get Endpoint Name
Room.prototype.getEndpointName = function (endpoint) {
  return this.endpoints[endpoint].name;
};

// Remove Endpoint
Room.prototype.removeEndpoint = function (endpointId) {
  delete this.endpoints[endpointId];
};

// Get Roomname
Room.prototype.getRoomName = function (endpointId) {
  return this.roomname;
};

module.exports = Room;
