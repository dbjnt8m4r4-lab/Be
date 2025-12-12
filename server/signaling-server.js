// WebSocket signaling server for WebRTC
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

// Track connected clients
const clients = new Map();

wss.on('connection', (ws, req) => {
  console.log('New client connected');
  
  // Generate a unique ID for the client
  const clientId = Date.now().toString();
  clients.set(clientId, ws);
  
  // Send the client their ID
  ws.send(JSON.stringify({
    type: 'connection',
    clientId: clientId
  }));

  ws.on('message', (message) => {
    try {
      const data = JSON.parse(message);
      console.log('Received message:', data);
      
      // Handle different types of messages
      switch (data.type) {
        case 'offer':
        case 'answer':
        case 'candidate':
          // Forward the message to the target peer
          const targetClient = clients.get(data.target);
          if (targetClient && targetClient.readyState === WebSocket.OPEN) {
            targetClient.send(JSON.stringify({
              ...data,
              sender: clientId
            }));
          }
          break;
          
        case 'ping':
          // Respond to ping messages
          ws.send(JSON.stringify({ type: 'pong' }));
          break;
      }
    } catch (error) {
      console.error('Error handling message:', error);
    }
  });

  ws.on('close', () => {
    console.log('Client disconnected:', clientId);
    clients.delete(clientId);
    
    // Notify other clients about the disconnection
    broadcast({
      type: 'peer-disconnected',
      clientId: clientId
    });
  });
  
  ws.on('error', (error) => {
    console.error('WebSocket error:', error);
  });
});

// Helper function to broadcast to all clients
function broadcast(message) {
  const data = typeof message === 'string' ? message : JSON.stringify(message);
  for (const [id, client] of clients.entries()) {
    if (client.readyState === WebSocket.OPEN) {
      client.send(data);
    }
  }
}

console.log('Signaling server running on ws://localhost:8080');
