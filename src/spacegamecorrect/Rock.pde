class rock {
  // Member Variables
  int x, y, diam, speed,health;
int initialDiam;
  PImage rock1;

  //Constructor
  rock() {
    x=int (random(width));
    y=-100;
    diam=int(random(50, 100));
    initialDiam=diam;
    speed =int(random(3, 5));
    health=2;
    if (random(10)>6.6) {
      rock1=loadImage("rock1.png");
    } else if (random(10)>5.0) {
      rock1=loadImage("rock1.png");
    } else {
      rock1=loadImage("rock1.png");
    }
  }

  //Member Methods
  void display() {
    imageMode(CENTER);
    //rock1.resize(diam, diam);
    image(rock1, x, y,diam,diam);
  }

  void move() {
    y=y+speed;
  }


  boolean reachedBottom() {
    if (y>height+diam/2) {
      return true;
    } else {
      return false;
    }
  }
}
