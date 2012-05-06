// #import('dart:html');
// #import('dart:json');

class GameClient {
  WebSocket socket;
  DrawCanvas drawCanvas;
  Element el;
  bool isVisible;
  Map player1;
  Map player2;
  int score = 0;
  Element scoreEl;
  int score2 = 0;
  Element scoreEl2;
  // bool isConnected = false;
  Element inputBox;
  
  GameClient(this.el, this.drawCanvas) {
    isVisible = false;
    scoreEl = document.query('#player1 .score');
    scoreEl2 = document.query('#player2 .score');
    
    inputBox = el.query('input');
    inputBox.on.keyDown.add((e) {
      if (e.keyCode == 13){
        print(inputBox.value);
        
        socket.send(JSON.stringify({'action': 'testWord', 'args': {
          'nickname': player1['nickname'],
          'word': inputBox.value
        }}));
      }
    });
  }
  
  register(nickname,avatar) {
    setPlayer1(nickname);
    socket.send(JSON.stringify({'action': 'register', 'args': nickname,'avatar':avatar}));
  }
  
  startGame(args) {
    if (!isVisible){
      el.style.zIndex = '1';
      el.style.display = 'block';
      el.style.opacity = '1';
      document.query('#profile').style.display = 'none';
    }
    // ready
    if (args['player2'] != null){
      Element avatar = document.query('#${args['player2']['avatar']}');
      // print(document.query('#${args['player2']['avatar']}'));
      // print(args['player2']['avatar']);
      document.query('#player2 img').src = avatar.src;
      el.query('#player2 h2').innerHTML = args['player2']['nickname'];
      this.drawCanvas.Init();
      print(args['word']);
      this.drawCanvas.startNewRound(args['word']);
    }
    el.query('#player1 h2').innerHTML = player1['nickname'];
  }
  
  nextRound(args){
    inputBox.value = '';
    if (args['win']){
      this.drawCanvas.playerWon(1);
      score += 1;
      scoreEl.innerHTML = score.toString();
    }else{
      score2 += 1;
      scoreEl2.innerHTML = score2.toString();
      this.drawCanvas.playerWon(2);
    }
    
    window.setTimeout((){
      drawCanvas.startNewRound(args['word']);
    }, 2000);
  }
  
  setPlayer1(nickname) {
    player1 = {'nickname': nickname};
  }
  
  connect() {
    print('SOCKET CONNECTING...');
    socket = new WebSocket("ws://127.0.0.1:9000/ws");

    socket.on.open.add((e) {
      print('SOCKET CONNECTED');
      // isConnected = true;
    });
    
    socket.on.message.add((m) {
      print('MESSAGE RECEIVED ${m.data}');
      var data = JSON.parse(m.data);
      
      switch(data['action']) {
        case 'startGame':
          startGame(data['args']);
          break;
        case 'nextRound':
          nextRound(data['args']);
          break;
      }
      
    });
    
    socket.on.close.add((e) {
      print('SOCKET DISCONNECTED');
      window.setTimeout(connect, 2000);
    });
  }
}