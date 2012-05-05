#import('dart:html');

//program starts here
main() {
  new MainGameScreen().Init();
}

//class that deals with Canvas stuff
class MainGameScreen {
  
  //initialize the canvas we'll be drawing on
  Init(){
    CanvasElement canvas = document.query("#canvas");
    ctx = canvas.getContext("2d");
    window.setInterval(f() => drawFrame(), 20);
    word_x = 512;
    word_y = 180;
    wordText = "banana";
    player1Won = true  ;
    isStopped = false;
    
  }

  // draws a single frame of the game
  void drawFrame() {
    document.query('#status').innerHTML = "chegou aqui 3";
    ctx.clearRect(0, 0, 1024, 400);
    ctx.setLineWidth(1);

    drawWord(word_x, word_y, wordText);
    if (!isStopped){
      if (word_y>(SCREEN_LIMIT+10))
        word_y=5;
      word_y++;
    }
  }
  
  // draws a banana at X,Y and with a given text
  void drawWord(num x, num y, String text){
    document.query('#status').innerHTML = "chegou aqui 4";
    if (isStopped){
      if (player1Won)
        ctx.setStrokeColor(PLAYER1_TEXT_COLOR);
      else
        ctx.setStrokeColor(PLAYER2_TEXT_COLOR);
    }else
      ctx.setStrokeColor(NORMAL_TEXT_COLOR);
    ctx.font = "20pt Arial";
    if (isStopped)
    { 
      // fun stuff .. this does the blincking
      drawNow++;
      if (drawNow>2){
        ctx.strokeText(text, x, y);
        if (drawNow>20)
          drawNow=0;
      }
    }else
      ctx.strokeText(text, x, y);
    
    //this should fill the text, but it's not working right now ...
    /*ctx.setFillColor(PLAYER1_TEXT_COLOR);
    ctx.fillStyle = PLAYER1_TEXT_COLOR;
    ctx.fill();
    */
    document.query('#status').innerHTML = "chegou aqui 5";
  }
  
  /**
  * Call this to set that a player won
  **/
  void playerWon(int playerNumber){
    isStopped=true;
    if (playerNumber==1)
    {
      player1Won = true;
    }
    else{
      player1Won = false;
    }
  }
  
  /**
  * Starts a new Round with a given word
  **/
  void startNewRound(String word){
    isStopped=false;
    wordText= word;
    
  }
  
  //variables here
  CanvasRenderingContext2D ctx;
  static final String BACKGROUND_COLOR = "orange";
  static final String NORMAL_TEXT_COLOR = "black";
  static final String PLAYER1_TEXT_COLOR = "blue";
  static final String PLAYER2_TEXT_COLOR = "red";
  
  int word_x, word_y;
  final int SCREEN_LIMIT = 400;
  
  String wordText;
  
  bool isStopped; // defines that word animation is stopped
  int drawNow=0;
  bool player1Won;
}