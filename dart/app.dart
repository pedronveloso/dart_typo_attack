#import('dart:html');
#source('profile.dart');
#source('DrawCanvas.dart');

class app {
  void startgamephase(){
    document.query("#profile").classes.add("hidden");
  }
}

void main() {
  
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
