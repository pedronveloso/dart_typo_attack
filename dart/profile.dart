class Profile{
  int avatar;
  String name;
  String session;
  GameClient game;
  Element startBtn;
  
  Profile(Element el, this.game) {
    startBtn = el.query('button');
    startBtn.on.click.add((e) {
      this.name = el.query('input').value;
      game.register(this.name);
    });
  }
  
  void loadavatarselection(){
    document.query('#avatarslist').on.click.add((event) {
     if (event.target.id.contains(new RegExp("[0-9]"))){
        if (this.avatar != null) this.avatar.classes.remove('avatarselected');
         event.target.classes.add('avatarselected');
        this.avatar = event.target;
     }
    });
  }
  
  void collectdatnsubmit(){
    document.query('#startbtn').on.click.add((event){
      this.name = document.query('#fname').value;
      // document.query("#profile").style.left="-500px";
    });
  } 
  void listen2playerdatasumission(){
    loadavatarselection(); 
    collectdatnsubmit();
  }
  
}
