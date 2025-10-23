class PowerUp {
// Member Variables
int x, y, w, speed;
char type;
PImage power;
color c1;

PowerUp() {
x=int (random(width));
y=-100;
w=100;
speed =int(random(1,5));

if(random(10)>7) {
  type='a'; //ammo
  c1= color (255, 0, 0);
  power=loadImage("ammo.png");

} else {
  //if (random(10)>5.0) {
  type='h'; //health
  c1=color(0, 255, 0);
  //} else {
  power=loadImage("healthstar.png");
// rock1=loadImage("turret.png");
  //type = 't'; //This is Turret Count
  c1 = color(0,0,255);
}
}
// Member Methods
void display() {
    imageMode(CENTER);
    imageMode(CENTER);
    power.resize(100, 100);
    image(power, x, y);
  }

void move() {
y = y + speed;
}


boolean reachedBottom() {
if (y>height + 100) {
return true;
} else {
return false;
}
}

boolean intersect(Spaceship s) {
float d = dist(x, y, s.x, s.y);
if (d<50) {
return true;
} else {
return false;
}
}
}
