class Game {
  Map<String, WebSocketConnection> players;
  List words;
  int index = 0;
  String lastWord;
  Map Avatars;
  Game() {
    players = new Map();
    Avatars = new Map();
    words = ['nothing', 'broadcast', 'cast', 'cost', 'cut', 'drunk', 'felt', 'forecast', 'ground', 'hit', 'lent', 'offset'];
  }
  
  String newPlayerId() {
    return uid() + uid + uid() + uid();
  }
  
  String NextWord(){
    /*double rndm = Math.random()*5450;
    return words[rndm.round()];*/
   var word = words[index];
   index++;
   if (index == words.length){
     index = 0;
   }
   return word;
 }
  
  register(nickname, avatar, conn) {
    if (players.containsKey(nickname)){
      conn.send(JSON.stringify({'action': 'nicknameExists'}));
    }else{
      var ready = false;
      String word =  'teste';
      var player2 = null;
      players[nickname] = conn;
      this.Avatars[nickname] = avatar;
      if (players.length >= 2){
        ready = true;
        word = NextWord();
        lastWord = word;
        players.forEach((k,v){
          if (k != nickname){
            player2 = {'nickname': k, 'avatar': Avatars[k]};
            v.send(JSON.stringify({
              'action': 'startGame',
              'args': {'ready': ready, 'player2': {'nickname': nickname, 'avatar': avatar}, 'word': word}
            }));
          }
        });
      }
      conn.send(JSON.stringify({
        'action': 'startGame',
        'args': {'ready': ready, 'player2': player2, 'word': word}
      }));
      print(players);
    }
  }
  
  testWord(args) {
    if (args['word'] == lastWord){
      lastWord = NextWord();
      players.forEach((k,v) {
        if (k == args['nickname']){
          // ganhou
          v.send(JSON.stringify({
            'action': 'nextRound',
            'args': {'win': true, 'word': lastWord}
          }));
        }else{
          // perdeu
          v.send(JSON.stringify({
            'action': 'nextRound',
            'args': {'win': false, 'word': lastWord}
          }));
        }
      });
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