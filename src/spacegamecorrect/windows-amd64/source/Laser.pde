class Laser {
  // Member Variables
  int x, y, speed;
  PImage laser;
  

  //Constructor
  Laser(int x, int y) {
    this.x=x;
    this.y=y;
    speed=10;
   
    laser = loadImage("laser1.png");
    
 
    }
    
  



  //Member Methods
  void display() {
      image(laser,x,y);
      
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
