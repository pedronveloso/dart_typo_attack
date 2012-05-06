class Game {
  Map<String, WebSocketConnection> players;
  
  Game() {
    players = new Map();
  }
  
  String newPlayerId() {
    return uid() + uid + uid() + uid();
  }
  
  register(nickname, conn) {
    if (players.containsKey(nickname)){
      conn.send(JSON.stringify({'action': 'nicknameExists'}));
    }else{
      var ready = false;
      var player2 = null;
      players[nickname] = conn;
      if (players.length >= 2){
        ready = true;
        players.forEach((k,v){
          if (k != nickname){
            player2 = {'nickname': k};
            v.send(JSON.stringify({
              'action': 'startGame',
              'args': {'ready': ready, 'player2': {'nickname': nickname}}
            }));
          }
        });
      }
      conn.send(JSON.stringify({
        'action': 'startGame',
        'args': {'ready': ready, 'player2': player2}
      }));
      print(players);
    }
  }
  
  unregister(conn) {
    players.forEach((k,v) {
      if (v == conn){
        players.remove(k);
      }
    });
    print(players);
  }
}

String uid() {
  return ((1+Math.random())*0x10000).round().toString().substring(0, 5);
}