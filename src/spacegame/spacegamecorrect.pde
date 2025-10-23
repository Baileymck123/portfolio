// Bailey McKeithen | 17 Sep 2025 | SpaceGame

// setup a timer and you start it when you level up then while the timer 
//is running display level up 
Spaceship luckycharms;

ArrayList<rock> rocks = new ArrayList<rock>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();

Timer rocktimer;
Timer powerUpTimer,levelTimer;

int score, rocksPassed,level;
boolean play = false;



PImage startImage;
PImage endImage;

void setup() {
  size(800, 800);
  background(20);
level=1;
  luckycharms = new Spaceship();
  luckycharms.turretCount = 1;

  rocktimer = new Timer(900);
  rocktimer.start();

  powerUpTimer = new Timer(4000);
  powerUpTimer.start();
  
   levelTimer = new Timer(40000);
  levelTimer.start();

  score = 0;
  rocksPassed = 0;
  

  startImage = loadImage("spacegame.png");
  endImage = loadImage("endImage.png");

  // create stars
  for (int i = 0; i < 100; i++) {
    stars.add(new Star());
  }
}

void draw() {
  if (!play) {
    startScreen();
  } 
  else if (luckycharms.health <= 0 || rocksPassed >= 10) {
    gameOverScreen();
  } 
  else {
    // Main game 
    background(20);

    // Stars
    for (Star s : stars) {
      s.display();
    }
    //levels check
    if (score >= level * 500){
    level++;
    // Make the game harder:
    int newRockTime = max(500, 2000 - level * 200); 
    rocktimer = new Timer(newRockTime);
    }

    // Rocks
    if (rocktimer.isFinished()) {
      rocks.add(new rock());
      rocktimer.start();
    }

    for (int i = rocks.size() - 1; i >= 0; i--) {
      rock r = rocks.get(i);
      r.display();
      r.move();

      if (luckycharms.intersect(r)) {
        rocks.remove(i);
        score += r.diam;
        luckycharms.health -= 10;
      } 
      else if (r.reachedBottom()) {
        rocksPassed++;
        rocks.remove(i);
      }
    }

    if (powerUpTimer.isFinished()) {
      powerUps.add(new PowerUp());
      powerUpTimer.start();
    }
    
    for (int i = 0; i < powerUps.size(); i++) {
      PowerUp p = powerUps.get(i);
      p.display();
      p.move(); 
    
      // Check collision with spaceship
      if (p.intersect(luckycharms)) {
        if (p.type == 'a') {
          luckycharms.laserCount += 10;
        } else if (p.type == 'h') {
          luckycharms.health += 10;
        } else if (p.type == 't') {
          luckycharms.turretCount++;
        }
        powerUps.remove(i);
      } else if (p.reachedBottom()) {
        powerUps.remove(i);
      }
    }
    
  }

    // Lasers
  //Display and move Lasers
  for (int i = 0; i < lasers.size(); i++) {
    Laser laser = lasers.get(i);
    for (int j = 0; j<rocks.size(); j ++) {
      rock r = rocks.get(j);
      if (laser.intersect (r)) {
        lasers.remove(laser);
        score+= r.diam;
        r.diam -= 50;
        if (r.diam<5) {
          rocks.remove(r);
        }
        println("score:" + score);
        println("r.diam:" + r.diam);
        
      }
    }
    laser.display();
    laser.move();
    if (laser.reachedTop()) {
       lasers.remove(laser);
    }
    //println("Lasers;" + lasers.size());
}

     // if (!hit) {
        //laser.display();
        //laser.move();
       // if (laser.reachedTop()) lasers.remove(i);
     // }
   // }

    // Spaceship
    luckycharms.display();
    luckycharms.move(mouseX, mouseY);
    infoPanel();
   //level
fill(255);
textSize(30);
textAlign(RIGHT, TOP);
text("Level: " + level, width - 20, 20);

  }



void mousePressed() {
  if (!play) {
    play = true;  
    return;
  }
  
  if (luckycharms.turretCount == 1) {
  lasers.add(new Laser(luckycharms.x, luckycharms.y));
  }else if (luckycharms.turretCount == 2) {
    lasers.add(new Laser(luckycharms.x-10, luckycharms.y));
    lasers.add(new Laser(luckycharms.x+10, luckycharms.y));
  }else if (luckycharms.turretCount == 3) {
  lasers.add(new Laser(luckycharms.x, luckycharms.y));
  lasers.add(new Laser(luckycharms.x-10, luckycharms.y));
  lasers.add(new Laser(luckycharms.x+10, luckycharms.y));
  }else{
  lasers.add(new Laser(luckycharms.x, luckycharms.y));
  lasers.add(new Laser(luckycharms.x-10, luckycharms.y));
  lasers.add(new Laser(luckycharms.x+10, luckycharms.y));
  }
  
  luckycharms.laserCount -= 1;
  
}

void startScreen() {
  background(0, 0, 30);
  imageMode(CENTER);
  image(startImage, width / 2, height / 2, width, height);

  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("SpaceGame", width / 2, 100);
  textSize(30);
  text("Bailey McKeithen", width / 2, 150);
  text("Click to Start", width / 2, 200);
}

void gameOverScreen() {
  background(0);
  imageMode(CENTER);
  image(endImage, width / 2, height / 2, width, height);

  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(50);
  text("GAME OVER", width / 2, height - 100);
  textSize(30);
  text("Final Score: " + score, width / 2, height - 50);
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  noStroke();
  rect(width / 2, height - 25, width, 50);

  fill(40, 0, 40);
  textSize(30);
  textAlign(LEFT);
  text("Score: " + score, 50, height - 10);
  text("Rocks Passed: " + rocksPassed, 250, height - 10);
  text("Health: " + luckycharms.health, 500, height - 10);
  text("Ammo: " + luckycharms.laserCount, 650, height - 10);
}
