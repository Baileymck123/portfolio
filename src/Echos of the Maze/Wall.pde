//Kirubashinilakshana
class Wall {
  float x, y, w, h;

  Wall(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

/// AABB collision detection
  boolean intersects(Player p) { // checks if two rectangles overlap
    return (p.x + p.w/2 > x - w/2 &&
      p.x - p.w/2 < x + w/2 &&
      p.y + p.h/2 > y - h/2 &&
      p.y - p.h/2 < y + h/2);
  }


  void display() {
    fill(100, 100, 100);
    noStroke();
    rect(x, y, w, h);
  }
}
