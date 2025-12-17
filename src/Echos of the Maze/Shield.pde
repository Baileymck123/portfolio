//Bailey
//Gives health to the player in the maze
class Shield {

  // Position and size
  int x, y, w;

  // Shield image
  PImage shield;

  Shield() {
    // Random spawning
       x = int(random(120, 1080));//only spawns within maze
    y = int(random(120, 580));
    w = 40;

    shield = loadImage("shield.png");
    shield.resize(w, w);
  }

  void display() {
    imageMode(CENTER);
    image(shield, x, y);
  }

  // Collision with player
  boolean intersect(Player s) {
    float d = dist(x, y, s.x, s.y);
    return d < (w/2 + 20);   // 20 is the player hit radius
  }
}
