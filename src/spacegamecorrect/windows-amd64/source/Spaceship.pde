class Spaceship {
// Member Variables
int x,y,w,laserCount, turretCount, health;

//Constructor
Spaceship(){
x=width/2;
y=height/2;
w=100;
health=100;
laserCount=100;
//
}

//Member Methods
void display(){
  rectMode(CENTER);
// Body
  fill(0, 100, 100);
  stroke(0,0,150);
  strokeWeight(3);
  rect(x, y + 40, 30, 80);
 

  // Wings
  fill(0, 100, 0);
  stroke(0,0,150);
  strokeWeight(2);
  triangle(x - 15, y + 60, x - 30, y + 90, x - 15, y + 80);
  triangle(x + 15, y + 60, x + 30, y + 90, x + 15, y + 80);
 
 //fire
 fill(255,160,0);
 stroke(255,10,0);
  strokeWeight(2);
  triangle(x - 30, y + 110, x - 45, y + 130, x - 30, y + 120);  // left
  triangle(x + 30, y + 110, x + 45, y + 130, x + 30, y + 120);  // right
 
 
  //triangle on top
  fill (0,100,0);
  stroke(0,0,150);
  triangle(x - 10, y - 3, x + 10, y - 3, x, y - 60);
 
 //window
 fill (0,90,150);
 stroke(100);
 ellipse(x,y+10,15,15);
 

  // circle on top
  fill(255);
  stroke(255);
  ellipse(x, y - 60, 8, 8);
}

void move(int x,int y) {
this.x = x;
this.y = y;
}

boolean fire(){
if (laserCount>0){
return true;
}else{
  return false;
}
}

boolean intersect(rock r) {
  float d= dist(x,y,r.x,r.y);
  if(d<50){
    return true;
  }else{
    return false;
  }
}

boolean intersect(PowerUp r) {
float d= dist(x,y,r.x,r.y);
  if(d<50){
    return true;
  }else{
    return false;
  }
}


}
