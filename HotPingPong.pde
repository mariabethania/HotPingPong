
// Este es el Mero Mero

import peasy.*;
import ddf.minim.*;

PeasyCam cam;
Minim minim;
AudioPlayer ping, pong, dingL, dingR, startDing;
AudioPlayer padL, padR, rightBounce, leftBounce;
Timer timer;

Ball ball;
Paddle left;
Paddle right;
Paddle aiLpad;
Paddle aiRpad;
boolean aiLbool = false;
boolean aiRbool = false;
boolean mouseRMove = false;
boolean mouseLMove = false;
boolean fire = false;
boolean tittle = true;
boolean[] keys = new boolean[8];
int leftScore, rightScore, aiLscore, aiRscore;
int W = 1000;
int H = 500;
float xRotate = 0.3;
float zRotate;
float zTranslate = 0;
float aiYL = H/2;
float aiYspeedL = 0;
float aiSpeedL = 0;
float aiYR = H/2;
float aiYspeedR = 0;
float aiSpeedR = 0;
float mx;
float my;
float mz;
boolean click = false;
//int choice = -1;
int level = 1;
int error = 5;
int constant = 20;
float moveLeft;
float moveRight;

ParticleSystem ps;
ChispaSystem cs;
//ParticleSystem ps1;
//Particle p1;
//PVector colLeft,colRight,colLai,colRai;


int a, b, c, d;

void setup() {
  size(1200, 600, P3D);
  //frameRate(12);
  for (int i = 0; i<4; i++) {
    keys[i] = false;
  }
  //cam = new PeasyCam(this, 520);
  ps = new ParticleSystem();
  cs = new ChispaSystem();
  // ps1 = new ParticleSystem();
  timer = new Timer(3);
  minim = new Minim(this);
  ball = new Ball(W, H);
  left = new Paddle(true, W, H);
  right = new Paddle(false, W, H);
  aiLpad = new Paddle(true, W, H);
  aiRpad = new Paddle(false, W, H);
  ping = minim.loadFile("BallUp.mp3");
  pong = minim.loadFile("BallDown.mp3");
  padL = minim.loadFile("PaddleLeft.mp3");
  padR = minim.loadFile("PaddleRight.mp3");
  dingL = minim.loadFile("DingLeft.mp3");
  dingR = minim.loadFile("DingRight.mp3");
  leftBounce = minim.loadFile("leftBouncing.mp3");
  rightBounce = minim.loadFile("rightBouncing.mp3");
  startDing = minim.loadFile("StartDing.mp3");
  startDing.setGain(-10);
}

void draw() {
  background(0);
  textAlign(CENTER, CENTER);
  lights();
  pushMatrix();
  translate(0,0,0);
  if (tittle) {
    textSize(18);
    fill(150);
    text("Press 'SPACE' for left serve or 'ENTER'for right serve at any time during the game.", width/2, height/35);
    text("'.' or '>' rotates the table forward - ',' or '<' rotates it backward - 'z' or 'Z' zoom in - 'x' or 'X' zoom out", width/2, height/14);
    text("Press shift + 1-3 for 3 levels of AI response - 'F1,F2,F3,F4' for players choice", width/2, height/9);
    //text("( 0 - 2 )",width/1.8,height/8);
    //fill(255);
  } else {
    textSize(24);
    //textAlign(CENTER);
    switch (level) {
    case 3:
    fill(200, 0, 0);
      text("AI Level = High", width/2, height/20);
      break;
    case 2:
    fill(200, 200, 0);
      text("AI Level = Medium", width/2, height/20);
      break;
    case 1:
    fill(0, 200, 0);
      text("AI Level = Low", width/2, height/20);
      break;
    }
  }

  if (aiLbool) {
    textSize(32);
    fill(0, 255, 50);
    text(leftScore, W/20, H/14);
    textSize(16);
    //fill(255);
    text("Human", W/20, H/7);
  } else 
  {
    textSize(32);
    fill(50, 170, 255);
    text(aiLscore, W/20, H/14);
    textSize(16);
    text("AI", W/20, H/7);
  }    

  if (aiRbool) {
    textSize(32);
    fill(255, 50, 50);
    text(rightScore, width-(W/20), H/14);
    textSize(16);
    text("Human", width-(W/20), H/7);
  } else 
  {
    textSize(32);
    fill(255, 0, 255);
    text(aiRscore, width-(W/20), H/14);
    textSize(16);
    text("AI", width-(W/20), H/7);
  }
popMatrix();
  //if (click) {
  //for (int i = 0; i < 10; i++) {
  //  cs.addChispas(mx, my, mz);
  //}
  //}
  //cs.runChispas();

  // the game starts 

  //textSize(32);
  //pushMatrix();
  translate(width/2, height/2,zTranslate);
  rotateX(xRotate);
  //rotateZ(zRotate);
  strokeWeight(2);
  stroke(170);
  fill(0, 200, 240,50);
  rectMode(CENTER);
  rect(0, 0, W, H);

  translate(-W/2, -H/2, 0);
  noFill();
  strokeWeight(1);
  stroke(100);
  line(W/2, 0, W/2, H/2-20);
  ellipse(W/2, H/2, 40, 40);
  line(W/2, H/2+20, W/2, H);
  //line(0,H/2,W,H/2);
  //popMatrix();
  // left pad
  if (aiLbool && aiRbool) {
    if (mouseLMove) {
      left.move(moveLeft);
    } else 
    {
      if (keys[0]) {
        left.move(-9);
      } else if (keys[1]) {
        left.move(9);
      }
    }
  } else 
  if (aiLbool && !aiRbool) {
    if (mouseLMove) {
      left.move(moveLeft);
    } else 
    {
      if (keys[0] || keys[2]) {
        left.move(-9);
      } else if (keys[1] || keys[3]) {
        left.move(9);
      }
    }
  } else {
    aiLpad.move(moveLeftAI());
  }
  // right pad
  if (aiRbool && aiLbool) {
    if (mouseRMove) {
      right.move(moveRight);
    } else 
    {
      if (keys[2]) {
        right.move(-9);
      } else if (keys[3]) {
        right.move(9);
      }
    }
  } else 
  if (aiRbool && !aiLbool) {
    if (mouseRMove) {
      right.move(moveRight);
    } else 
    {
      if (keys[2] || keys[0]) {
        right.move(-9);
      } else if (keys[3] || keys[1]) {
        right.move(9);
      }
    }
  } else {
    aiRpad.move(moveRightAI());
  }


  if (aiLbool) {
    fill(0, 255, 50);
    left.show();
  } else {
    fill(50, 170, 255);
    aiLpad.show();
  }

  if (aiRbool) {
    fill(255, 60, 60);
    right.show();
  } else {
    fill(255, 0, 255);
    aiRpad.show();
  }

  if (aiLbool) {
    ball.hitPaddleLeft();
  } else
  {
    ball.hitLeftPaddleAI();
  }

  if (aiRbool) {
    ball.hitPaddleRight();
  } else
  {
    ball.hitRightPaddleAI();
  }

if (keys[4]) {
    zTranslate += 1;
} else if (keys[5]) {
    zTranslate -= 1;
}

if (keys[6]) {
    xRotate += 0.005;
} else if (keys[7]) {
    xRotate -= 0.005;
}
//}

  ball.edges();
  ball.update();
  ball.show();
  //popMatrix();

  if (fire) {
    ps.addParticle(ball.x, ball.y, ball.z-22);//random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
    ps.run();
    cs.runChispas();
}
}

void keyPressed() {
  //print(keyCode);
  if (key == 'r') {
    fire = false;
    ball.x = W/2;
    ball.y = H/2;
    ball.yspeed = H/50;
    ball.xspeed = 0;
    aiLpad.y = H/2;
    aiRpad.y = H/2;
     aiSpeedL = 0;
     aiSpeedR = 0;
  } else if (key == 'R') {
    leftScore = 0;
    rightScore = 0;
    aiLscore = 0;
    aiRscore = 0;
    fire = false;
    ball.x = W/2;
    ball.y = H/2;
    ball.yspeed = H/50;
    ball.xspeed = 0;
    aiLpad.y = H/2;
    aiRpad.y = H/2;
     aiSpeedL = 0;
     aiSpeedR = 0;
  }
  
  if (key == '!') { 
    level = 1;
  } else if (key == '@') { 
    level = 2;
  } else if (key == '#') { 
    level = 3;
  }

  if (key == 'w' || key == 'W') {
    keys[0] = true;
  }
  if (key == 's' || key == 'S') {
    keys[1] = true;
  }
  if (keyCode == UP) {
    keys[2] = true;
  }
  if (keyCode == DOWN) {
    keys[3] = true;
  }

  if (keyCode == ENTER) {
    ball.serve();  
    ball.xspeed = -12;

    if (level == 1) {
      aiSpeedL = random(6, 8);
      aiSpeedR = random(1, 3);
    } else if (level == 2) {
      aiSpeedL = random(7, 9);
      aiSpeedR = random(1, 3);
    } else if (level == 3) {
      aiSpeedL = random(8, 10);
      aiSpeedR = random(1, 3);
    }
} else if (keyCode == 32) {
    ball.serve();  
    ball.xspeed = 12;

    if (level == 1) {
      aiSpeedR = random(6, 8);
      aiSpeedL = random(1, 3);
    } else if (level == 2) {
      aiSpeedR = random(7, 9);
      aiSpeedL = random(1, 3);
    } else if (level == 3) {
      aiSpeedR = random(8, 10);
      aiSpeedL = random(1, 3);
    }
  } 

  if (key == '.' || key == '>') {
    keys[6] = true;
    //xRotate += 0.01;
  } else if (key == ',' || key == '<') {
    keys[7] = true;
    //xRotate -= 0.01;
  }

  if (key == 'z' || key == 'Z') {
    keys[4] = true;
  } else if (key == 'x' || key == 'X') {
    keys[5] = true;
  }

  if (keyCode == 97) {
    aiRbool = false;
    aiLbool = false;
    //choice = key;
  } else if (keyCode == 98) {
    aiLbool = true;
    aiRbool = false;
    //choice = key;
  } else if (keyCode == 99) {
    aiLbool = true;
    aiRbool = true;
    //choice = key;
  } else if (keyCode == 100) {
    aiLbool = false;
    aiRbool = true;
    //choice = key;
  }
  if (key == 'M') {
    if (mouseRMove) {
      mouseRMove = false;
    } else {
      mouseRMove = true;
    }
  }
  if (key == 'm') {
    if (mouseLMove) {
      mouseLMove = false;
    } else {
      mouseLMove = true;
    }
  }
  //if (key == 1 && (key == 'l' || key =='L')) {
  //  aiLbool = true;
  //  aiRbool = false;
  //}
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    keys[0] = false;
  }
  if (key == 's' || key == 'S') {
    keys[1] = false;
  }
  if (keyCode == UP) {
    keys[2] = false;
  }
  if (keyCode == DOWN) {
    keys[3] = false;
  }
  
  if (key == 'z' || key == 'Z') {
    keys[4] = false;
    //zTranslate += 3;
  } else if (key == 'x' || key == 'X') {
    keys[5] = false;
    //zTranslate -= 3;
  }
  
  if (key == '.' || key == '>') {
    keys[6] = false;
  } else if (key == ',' || key == '<') {
    keys[7] = false;
    //xRotate -= 0.03;
  }
}

//void mousePressed() {
//  mx = mouseX;
//  my = mouseY;
//  click = true;
//}

void mouseReleased() {
  moveRight = 0;
  moveLeft = 0;
}

void mouseDragged() {
  if (mouseY < pmouseY) {
    moveRight = - ((pmouseY - mouseY)*1.5);
  } else if (mouseY > pmouseY) {
    moveRight = (mouseY - pmouseY)*1.5;
  }
  
  if (mouseY < pmouseY) {
    moveLeft = - ((pmouseY - mouseY)*1.5);
  } else if (mouseY > pmouseY) {
    moveLeft = (mouseY - pmouseY)*1.5;
  }
}

float moveRightAI() {
  if (aiRpad.y < ball.y-(aiRpad.h/2) && aiRpad.y < ball.y+(aiRpad.h/2)) {
    aiYspeedR = aiSpeedR;
  } else if (aiRpad.y > ball.y-(aiRpad.h/2) && aiRpad.y > ball.y+(aiRpad.h/2)) { // (error*level)-constant  -  (error*level)+constant
    aiYspeedR = -aiSpeedR;
  }
  return aiYspeedR;
}

float moveLeftAI() {

  if (aiLpad.y < ball.y-(aiLpad.h/2) && aiLpad.y < ball.y+(aiLpad.h/2)) {
    aiYspeedL = aiSpeedL;
  } else if (aiLpad.y > ball.y-(aiLpad.h/2) && aiLpad.y > ball.y+(aiLpad.h/2)) { // (error*level)-constant  -  (error*level)+constant
    aiYspeedL = -aiSpeedL;
  }
  return aiYspeedL;
}
