
//class that deals with Canvas stuff
class DrawCanvas {
  CanvasElement canvas;
  
  DrawCanvas(CanvasElement el) {
    canvas = el;
  }
  
  
  //initialize the canvas we'll be drawing on
  Init(){
    print('init');
    // CanvasElement canvas = document.query("#canvas");
    ctx = canvas.getContext("2d");
    window.setInterval(f() => drawFrame(), 20);
    word_x = 400;
    word_y = 180;
    wordText = "banana";
    player1Won = true  ;
    isStopped = false;
    loadedBananaImg = false;
    imgBanana = new Element.tag('img');
    imgBanana.src = "fighter.png";
    imgBanana.on.load.add((event) {
      loadedBananaImg=true;
    });
    print('init end');
    

      audio = new AudioElement();
      
      if (audio.canPlayType("audio/ogg", "") != "")
        audio.src = "background_music/imperial_march.ogg";
      
      audio.on["canplaythrough"].add(playAudio);
      audio.on["ended"].add(playAudio);

    
  }
  
  void playAudio(Event event)
  {
    print("${event.type}");
    audio.play();
  }

  // draws a single frame of the game
  void drawFrame() {
    ctx.clearRect(0, 0, 800, 350);
    ctx.setLineWidth(1);

    drawWord(word_x, word_y);
    if (!isStopped){
      if (word_y>(SCREEN_LIMIT+10))
        word_y=5;
      word_y++;
    }
  }
  
  // draws a banana at X,Y and with a given text
  void drawWord(num x, num y){
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
        ctx.strokeText(wordText, x-textSubtractLenght(wordText), y);
        if (drawNow>20)
          drawNow=0;
      }
    }else
      ctx.strokeText(wordText, x-textSubtractLenght(wordText), y);
    
    if (loadedBananaImg) {
      ctx.drawImage(imgBanana, x-64, y-140);
    }
    
   // });
    //this should fill the text, but it's not working right now ...
    /*ctx.setFillColor(PLAYER1_TEXT_COLOR);
    ctx.fillStyle = PLAYER1_TEXT_COLOR;
    ctx.fill();
    */
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
    isStopped = false;
    wordText = word;
  }
  
  int textSubtractLenght(String text){
    return 7*text.length;
  }
  
  /**
  *clears screen and starts the game phase
  **/
  //variables here
  CanvasRenderingContext2D ctx;
  static final String NORMAL_TEXT_COLOR = "white";
  static final String PLAYER1_TEXT_COLOR = "blue";
  static final String PLAYER2_TEXT_COLOR = "red";
  
  int word_x, word_y;
  final int SCREEN_LIMIT = 350;
  
  String wordText;
  
  bool isStopped; // defines that word animation is stopped
  int drawNow=0;
  bool loadedBananaImg = false;
  bool player1Won;
  ImageElement imgBanana;
  
  AudioElement audio;
}