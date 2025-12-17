// Bailey, Adeline, Kirubashinilakshana | Nov 5
Player edgar;
Button btnStart, btnMenu, btnSettings, btnBack;

int score;
int level = 1; 
float timeLeft = 10;

ArrayList<Ghost> ghosts;
ArrayList<Coin> coins;
ArrayList<Wall> walls;
ArrayList<Spear> spears;
ArrayList<Spider> spiders;
ArrayList<Shield> shields;
//Timer logic
Timer spidertimer;

PImage start, menu, end;

boolean play;          // if true = game running
boolean instructions;  // if true = instructions screen

import processing.sound.*; //Creating sound effects
SoundFile sound;

void setup() {
  size(1200, 700);
  rectMode(CENTER);

  // Load images
  menu = loadImage("menu.png");
  start = loadImage("start.png");
  end = loadImage("EndPage.png");

  score = 0;
  edgar = new Player();      // main player
  sound = new SoundFile(this, "woosh.mp3");
//Timer logic
  spidertimer = new Timer(5000); 
  spidertimer.start();

  // Create buttons
  btnStart = new Button("Start", 390, 315, 395, 140);
  btnMenu  = new Button("How to Play", 390, 508, 395, 140);
  btnBack  = new Button("Back", 20, 20, 200, 80);

  // Initialize arrayslist
  ghosts  = new ArrayList<Ghost>();
  coins   = new ArrayList<Coin>();
  walls   = new ArrayList<Wall>();
  spears  = new ArrayList<Spear>();
  spiders = new ArrayList<Spider>();
  shields = new ArrayList<Shield>();

  // Display coins and  ghosts
  for (int i = 0; i < 5; i++) coins.add(new Coin());
  for (int i = 0; i < 3; i++) ghosts.add(new Ghost());


  // Walls to form maze
  walls.add(new Wall(600, 40, 1000, 15));
  walls.add(new Wall(105, 320, 15, 574));
  walls.add(new Wall(1100, 268, 15, 470));
  walls.add(new Wall(600, 600, 1000, 15));

  walls.add(new Wall(403, 145, 400, 15));
  walls.add(new Wall(150, 300, 106, 15));
  walls.add(new Wall(596, 95, 15, 100));
  walls.add(new Wall(596, 270, 15, 70));
  walls.add(new Wall(888, 270, 15, 70));

  walls.add(new Wall(810, 400, 15, 150));
  walls.add(new Wall(700, 500, 15, 60));
  walls.add(new Wall(755, 475, 120, 15));

  walls.add(new Wall(888, 190, 15, 70));
  walls.add(new Wall(1000, 190, 15, 200));

  walls.add(new Wall(500, 415, 15, 65));
  walls.add(new Wall(388, 455, 370, 15));

  walls.add(new Wall(550, 525, 500, 15));
  walls.add(new Wall(795, 150, 200, 15));

  walls.add(new Wall(210, 300, 15, 300));
  walls.add(new Wall(300, 300, 15, 150));
  walls.add(new Wall(595, 230, 600, 15));
  walls.add(new Wall(960, 400, 290, 15));
  walls.add(new Wall(600, 300, 200, 15));
  walls.add(new Wall(700, 345, 15, 105));
  walls.add(new Wall(595, 390, 205, 15));
}

void draw() {
  // Instructions screen
  if (instructions) {
    instructionScreen();
    return;
  }

  // Start screen
  if (!play) {
    startScreen();
    return;
  }

  background(30, 0, 15);
  infoPanel();

  edgar.display();

 
  // Levels
  timeLeft -= 1.0/60;

  if (timeLeft <= 0) {
    level++;
    score += 100;
    timeLeft = 20;

    spiders.clear();

    // Spider difficulty increasesing with the levels
    int spiderCount = (level + 1) / 2;
    for (int i = 0; i < spiderCount; i++) spiders.add(new Spider());

    // Add shields, to give the player health every 5 levels
    int shieldCount = (level + 1) / 5;
    for (int i = 0; i < shieldCount; i++) shields.add(new Shield());
  }
  // If edgars health is zero it creates game over
  else if (edgar.health <= 0) {
    gameOverScreen();
    return;
  }

  // Game over when player reaches end 
  if (edgar.x < 0 || edgar.x > width || edgar.y < 0 || edgar.y > height) {
    gameOverScreen();
    return;
  }

  // Draw walls
  for (Wall w : walls) w.display();

  // Coin logic
  for (int i = coins.size() - 1; i >= 0; i--) {
    Coin c = coins.get(i);
    c.display();

    if (c.intersect(edgar)) {
      score += 10;
      coins.remove(i);
      coins.add(new Coin());
    }
  }

  // Ghost logic
  for (int i = ghosts.size() - 1; i >= 0; i--) {
    Ghost g = ghosts.get(i);
    g.display();

    if (g.y > height + g.diam/2) {
      ghosts.remove(i);
      ghosts.add(new Ghost());
      continue;
    }

    if (edgar.intersect(g)) {
      edgar.health -= 10;
      ghosts.remove(i);
      ghosts.add(new Ghost());
    }
  }

  // Spider logic
  for (int i = spiders.size() - 1; i >= 0; i--) {
    Spider sp = spiders.get(i);
    sp.display();
    sp.move();

    if (sp.y > height + sp.diam/2) {
      spiders.remove(i);
      spiders.add(new Spider());
      continue;
    }

    if (edgar.intersect(sp)) {
      edgar.health -= 50;
      score -= 50;
      spiders.remove(i);
      spiders.add(new Spider());
    }
  }

  // Spear logic
  for (int i = spears.size() - 1; i >= 0; i--) {
    Spear s = spears.get(i);
    s.move();
    s.display();

    if (s.reachedEdge()) {
      spears.remove(i);
      continue;
    }

    // Spear and Ghost collision
    for (int g = ghosts.size() - 1; g >= 0; g--) {
      Ghost ghost = ghosts.get(g);
      if (dist(s.x, s.y, ghost.x, ghost.y) < ghost.diam / 2) {
        score += 10;
        ghosts.remove(g);
        ghosts.add(new Ghost());
        spears.remove(i);
        break;
      }
    }

    // Spear and Spider collision
    for (int sp = spiders.size() - 1; sp >= 0; sp--) {
      Spider spider = spiders.get(sp);
      if (dist(s.x, s.y, spider.x, spider.y) < spider.diam / 2) {
        score += 50;
        spiders.remove(sp);
        spiders.add(new Spider());
        spears.remove(i);
        break;
      }
    }
  }

// Shield and player collision
  for (int sh = shields.size() - 1; sh >= 0; sh--) {
    Shield h = shields.get(sh);
    h.display();

    if (h.intersect(edgar)) {
      edgar.health += 25;
      shields.remove(sh);
      shields.add(new Shield());
    }
  }
}

void keyPressed() {
  // Keeping the old position keeping edgar in the smae place after hitting the wall
  float prevX = edgar.x;
  float prevY = edgar.y;

  // Movement keys
  if (key == 'w') edgar.y -= 10;
  if (key == 's') edgar.y += 10;
  if (key == 'a') edgar.x -= 10;
  if (key == 'd') edgar.x += 10;

  // Wall collision check
  for (Wall w : walls) {
    if (w.intersects(edgar)) {
      // Undo movement to stop hitting walls
      edgar.x = prevX;
      edgar.y = prevY;
      break;
    }
  }

  // Spear shooting directions
  if (play && edgar.spearCount > 0) {
    if (keyCode == UP) {
      spears.add(new Spear((int)edgar.x, (int)edgar.y, 0, -1));
      edgar.spearCount -= 5;
      sound.play();
    } else if (keyCode == DOWN) {
      spears.add(new Spear((int)edgar.x, (int)edgar.y, 0, 1));
      edgar.spearCount -= 5;
      sound.play();
    } else if (keyCode == LEFT) {
      spears.add(new Spear((int)edgar.x, (int)edgar.y, -1, 0));
      edgar.spearCount -= 5;
      sound.play();
    } else if (keyCode == RIGHT) {
      spears.add(new Spear((int)edgar.x, (int)edgar.y, 1, 0));
      edgar.spearCount -= 5;
      sound.play();
    }
  }
}

void mousePressed() {
  if (!play && !instructions) {
    if (btnStart.clicked()) play = true;
    if (btnMenu.clicked()) {
      instructions = true;
      return;
    }
  }

  if (instructions && btnBack.clicked()) {
    instructions = false;
    return;
  }
}

void instructionScreen() {
  background(0);
  imageMode(CENTER);
  image(menu, width/2, height/2);
  btnBack.display();

  fill(255);
  textAlign(CENTER);
  textSize(30);
}

void startScreen() {
  background(0);
  imageMode(CENTER);
  image(start, width/2, height/2);

  btnStart.display();
  btnMenu.display();

  fill(255);
  textAlign(CENTER);
  textSize(40);
}

void gameOverScreen() {
  background(0);
  imageMode(CENTER);
  image(end, width/2, height/2);

  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(30);
  text("Final Score: " + score, width / 2, height - 50);
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  noStroke();
  rect(width / 2, height - 25, width, 50);

  fill(255);
  textSize(18);
  textAlign(LEFT);

  int y = height - 10;

  text("Score: " + score,            50,  y);
  text("Health: " + edgar.health,   250,  y);
  text("Ammo: " + edgar.spearCount, 450,  y);
  text("Level: " + level,           650,  y);
  text("Next level in: " + nf(timeLeft, 1, 1) + "s", 850, y);
}
