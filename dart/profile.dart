class profile{
  int avatar;
  string name;
  string session;
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
    
    });
  } 
    void listen2playerdatasumission(){
    loadavatarselection(); 
    collectdatnsubmit();
  }
}