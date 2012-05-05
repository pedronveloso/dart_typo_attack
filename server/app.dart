#import('dart:io');
#import('dart:json');

String S4() {
  return ((1+Math.random())*0x10000).round().toString().substring(0, 5);
}

//Generate a pseudo-GUID by concatenating random hexadecimal.
String generateID() {
  return S4() + S4() + S4() + S4();
}

void main() {
  var players = []; 
  
  HttpServer server = new HttpServer();
  WebSocketHandler wsHandler = new WebSocketHandler();
  server.addRequestHandler((req) => req.path == "/ws", wsHandler.onRequest);
  
  wsHandler.onOpen = (WebSocketConnection conn) {
    String sessionid = generateID();
    
    print('new connection $conn');
    print('new player id $sessionid');
    
    players.add({'id': sessionid, 'conn': conn});
    
    conn.send(JSON.stringify({"action": "register", "args": [sessionid]}));
    
    conn.onMessage = (message) {
      print("message is $message");
      conn.send("Echo: $message");
    };
    
    conn.onClosed = (int status, String reason) {
      print('closed with $status for $reason');
    };
          
    conn.onError = (e) {
      print('Error was $e');
    };
  };
  
  server.listen('127.0.0.1', 9000);
}