#import('dart:io');
#import('dart:json');
#source('Game.dart');
#source('WordsGenerator.dart');
void main() {
  Game game = new Game();
  HttpServer server = new HttpServer();
  WebSocketHandler wsHandler = new WebSocketHandler();
  server.addRequestHandler((req) => req.path == "/ws", wsHandler.onRequest);
  
  wsHandler.onOpen = (WebSocketConnection conn) {
    print('new connection $conn');
    
    conn.onMessage = (message) {
      print('MESSAGE $message');
      var data = JSON.parse(message);
      switch(data['action']){
        case 'register':
          game.register(data['args'], conn);
          break;
      }
    };
    
    conn.onClosed = (int status, String reason) {
      print('closed with $status for $reason');
      game.unregister(conn);
    };
          
    conn.onError = (e) {
      print('Error was $e');
      game.unregister(conn);
    };
  };
  
  server.listen('127.0.0.1', 9000);
}