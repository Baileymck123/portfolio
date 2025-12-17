// Bailey
// Enemy spider that crawls across the maze
class Spider {

  int x, y;     // position
  int diam;     // size
  int speed;    // movement speed
  PImage spider;

  Spider() {
    x = int(random(100, width - 100));
    y = int(random(0, height - 5 - diam/2));

    diam = int(random(50, 100));
    speed = int(random(1, 4));

    spider = loadImage("spider.png");
  }

  void display() {
    imageMode(CENTER);
    image(spider, x, y, diam, diam);
  }

  void move() {
    x += speed;  // moves sideways
  }

  boolean reachedBottom() {
    return (y > height + diam/2);
  }

  // In case of collision with another spider
  boolean intersect(Spider g) {
    float d = dist(x, y, g.x, g.y);
    return (d < (diam/2 + g.diam/2));
  }
}
