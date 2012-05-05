#import('dart:html');

class profilemanager{
  int avatar;
  string name;  
  private loadavatarselection(){
    var avatarslist = document.query('#avatarslist');
    avatarslist.on.click.add((event) {
     if (event.target.id.contains('[0-9]')){
        if (this.avatar != null) this.avatar.classname.remove('avatarselected');
        document.query('#avatar'+event.target.id.substring(event.target.id.length)).className.add('avatarselected');
        this.avatar = event.target;
     }
    });
  }
  public run(){
    loadavatarselection();
  }
}

void main() {
  new profilemanager().run();
}
