#import('dart:html');

class typo_attack {

  typo_attack() {
  }

  void run() {
    write("Hello World!");
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
}

void main() {
  new typo_attack().run();
}
