#import('dart:html');

class profile{
  int avatar;
  string name;
  string session;
  private loadavatarselection(){
    document.query('#avatarslist').on.click.add((event) {
     if (event.target.id.contains(new RegExp("[0-9]"))){
        if (this.avatar != null) this.avatar.classes.remove('avatarselected');
         event.target.classes.add('avatarselected');
        this.avatar = event.target;
     }
    });
  }
  private collectdatnsubmit(){
    document.query('#startbtn').on.click.add((event){
    this.name = document.query('#fname').value;
    
    });
  } 
  private listen2playerdatasumission(){
    loadavatarselection(); 
    collectdata();
  }
 
 }

void main() {
  new profile().listen2playerdatasumission();
}
