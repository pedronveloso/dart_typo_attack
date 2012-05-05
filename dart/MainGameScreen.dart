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
    ctx.beginPath();
    ctx.clearRect(0, 0, 1024, 400);
    ctx.setLineWidth(2);
    ctx.setFillColor(BACKGROUND_COLOR);
    ctx.setStrokeColor(BACKGROUND_COLOR);
    ctx.fill();
    
    ctx.closePath();
    
    //draw line just to know it's working for now
    ctx.moveTo(0, 0);
    ctx.lineTo(500, 400);
    ctx.stroke();
  }
  
  // draws a banana at X,Y and with a given text
  void drawBanana(num x, num y, String text){
    //ctx.drawImage(canvas_OR_image_OR_video, sx_OR_x, sy_OR_y);  
  }
  
  //variables here
  CanvasRenderingContext2D ctx;
  static final String BACKGROUND_COLOR = "orange";
}