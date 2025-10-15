class Laser {
  // Member Variables
  int x, y, frame, frameCount, speed;
  PImage spriteSheet;
  PImage [] frames;

  //Constructor
  Laser(int x, int y) {
    this.x=x;
    this.y=y;
    speed=10;
    frame=0;
    frameCount=2;
    spriteSheet = loadImage("laser.png");
    int frameWidth = spriteSheet.width ;
    int frameHeight = spriteSheet.height/ frameCount;

 
    frames = new PImage[frameCount];
    for (int i = 0; i < frameCount; i++) {
      frames[i] = spriteSheet.get(i * frameWidth, 0, frameWidth, frameHeight);
    }
    
  }



  //Member Methods
  void display() {
    image(frames[frame], x, y);
    if (frameCount > 1) {
      frame = (frame + 1) % frameCount;//i added the frame-matt
  }
  }

  void move() {
    y=y-speed;
  }


  boolean reachedTop() {
    if (y<0-10) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(rock r) {
    float d= dist(x, y, r.x, r.y);
    if (d<30) {
      return true;
    } else {
      return false;
    }
  }
}
