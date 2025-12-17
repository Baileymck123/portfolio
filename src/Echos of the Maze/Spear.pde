//Bailey | Adeline
// What the player shoots 
class Spear {

  int x, y;      // position
  int speed;     // movement speed
  int dx, dy;    // direction (1,0,-1)

  Spear(int x, int y, int dx, int dy) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;

    speed = 10;  // how fast spears travel
  }

  void display() {
    stroke(255);
    strokeWeight(6);
    line(x, y, x + dx * 20, y + dy * 20);
  }

  void move() {
    x += dx * speed;
    y += dy * speed;
  }

  // If spear leaves the screen, remove it
  boolean reachedEdge() {
    return (x < 0 || x > width || y < 0 || y > height);
  }
}
