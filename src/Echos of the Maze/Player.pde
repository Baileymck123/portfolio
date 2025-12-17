//Bailey
class Player {

  float x, y;      // player position
  float w, h;      // player size
  int health;      // players health 
  int spearCount;  // ammo


  PImage character;

  // Constructor
  Player() {
    x = width / 2;
    y = height / 2;

    w = 55;
    h = 55;

    health = 100; //health player starts with
    spearCount = 100; //ammo player starts with

    character = loadImage("character1.png");
    character.resize(55, 55); //character size
  }

  // Draw player image
  void display() {
    imageMode(CENTER);
    image(character, x, y);
  }

  // Move the player to position
  void move(int x, int y) {
    this.x = x;
    this.y = y;
  }

  // Controls the players ability to fire
  boolean fire() {
    return spearCount > 0;
  }

 
  // Collision detection

  boolean intersect(Ghost g) {
    float d = dist(x, y, g.x, g.y);
    return d < 50;
  }

  boolean intersect(Coin c) {
    float d = dist(x, y, c.x, c.y);
    return d < 50;
  }

  boolean intersect(Spider s) {
    float d = dist(x, y, s.x, s.y);
    return d < 50;
  }
}
