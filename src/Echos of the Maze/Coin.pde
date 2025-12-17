//Bailey
// Creates a collectible coin in the maze
class Coin {

  int x, y;   // coin position
  int w;      // width/diameter of coin
  PImage coin;

  // Constructor
  Coin() {
     x = int(random(120, 1080));//only spawns within maze
    y = int(random(120, 580));
    w = 40;

    coin = loadImage("coin.png");
    coin.resize(w, w);
  }

  // Draw the coin
  void display() {
    imageMode(CENTER);
    image(coin, x, y);
  }

  // Checks if player touches coin
  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    return d < (w / 2 + 20);  // 20 = hitbox 
  }
}
