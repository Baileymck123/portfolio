//Bailey
// Creates an enemy ghost in the maze to damage players health
class Ghost {

  int x, y;       // position
  int diam;       // size of ghost
  PImage ghost;

  // Constructor
  Ghost() {
       x = int(random(120, 1080));//only spawns within maze
    y = int(random(120, 580));
    diam = 55;
    ghost = loadImage("ghost.png");
  }

  // Draw the ghost
  void display() {
    imageMode(CENTER);
    image(ghost, x, y, diam, diam);
  }

  // Checks if ghosts intersect
  boolean intersect(Ghost g) {
    float d = dist(x, y, g.x, g.y);
    return d < (diam / 2 + g.diam / 2);
  }
}
