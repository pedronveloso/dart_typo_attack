#import('dart:html');
#import('dart:json');

#source('Profile.dart');
#source('GameClient.dart');
#source('DrawCanvas.dart');

class app {
  void startgamephase(){

  }
}

void main() {
  var drawCanvas = new DrawCanvas(document.query('#game canvas'));
  var game = new GameClient(document.query('#game'), drawCanvas);
  var profile = new Profile(document.query('#profile'), game);
  // profile.listen2playerdatasumission();
  
  /*Element startBtn = document.query('#profile button');
  startBtn.on.click.add((e) {
    game.register(profile.avatar);
  });*/

  game.connect();
  
  window.on.resize.add((e) {
    //var height = game.el.style.height - 100; 
    //drawCanvas.canvas.style.height = height;
  });
}

_main() {
  var maingame = new app();
  maingame.startgamephase();
  var drawCanvas =  new DrawCanvas(document.query("#game>canvas"));
  drawCanvas.Init();
  Element inputBox = document.query("#inputbox");
  inputBox.on.keyDown.add((e) {
    if (e.keyCode == 13){
      drawCanvas.startNewRound("Saguim");
      /**codigo do profile **/
    }
  });
}
