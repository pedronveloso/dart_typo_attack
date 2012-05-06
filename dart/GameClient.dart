// #import('dart:html');
// #import('dart:json');

class GameClient {
  WebSocket socket;
  DrawCanvas drawCanvas;
  Element el;
  bool isVisible;
  Map player1;
  Map player2;
  // bool isConnected = false;
  
  GameClient(this.el, this.drawCanvas) {
    isVisible = false;
    
    Element inputBox = el.query('input');
    inputBox.on.keyDown.add((e) {
      if (e.keyCode == 13){
        print(inputBox.value);
        
        socket.send(JSON.stringify({'action': 'testWord', 'args': {
          'nickname': player['nickname'],
          'word': inputBox.value
        }}));
      }
    });
  }
  
  register(nickname) {
    setPlayer1(nickname);
    socket.send(JSON.stringify({'action': 'register', 'args': nickname}));
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
      el.query('#player2 h2').innerHTML = args['player2']['nickname'];
      this.drawCanvas.Init();
      print(args['word']);
      this.drawCanvas.startNewRound(args['word']);
    }
    el.query('#player1 h2').innerHTML = player1['nickname'];
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
      }
      
    });
    
    socket.on.close.add((e) {
      print('SOCKET DISCONNECTED');
      window.setTimeout(connect, 2000);
    });
  }
}