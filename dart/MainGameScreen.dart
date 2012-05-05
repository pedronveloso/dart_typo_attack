#import('dart:html');

//program starts here
main() {
  document.body.nodes.add(new Element.html('<div>"hello"</div>'));
  document.query('#status').innerHTML = "chegou aqui 1";
  new MainGameScreen().Init();
}

//class that deals with Canvas stuff
class MainGameScreen {
  
  //initialize the canvas we'll be drawing on
  Init(){
    document.query('#status').innerHTML = "chegou aqui 2";
    CanvasElement canvas = document.query("#canvas");
    ctx = canvas.getContext("2d");
    drawFrame();
  }

  // draws a single frame of the game
  void drawFrame() {
    document.query('#status').innerHTML = "chegou aqui 3";
    ctx.clearRect(0, 0, 1024, 300);
  }
  
  //variables here
  CanvasRenderingContext2D ctx;
}