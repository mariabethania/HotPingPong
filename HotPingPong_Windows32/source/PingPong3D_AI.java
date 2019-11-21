import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PingPong3D_AI extends PApplet {




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
float xRotate = 0.3f;
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
int level = 2;
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

public void setup() {
  
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

public void draw() {
  background(0);
  textAlign(CENTER, CENTER);
  lights();
  pushMatrix();
  translate(0,0,0);
  if (tittle) {
    textSize(18);
    fill(150);
    text("Press 'l' or 'L' for left serve and 'r' or 'R' for right serve at any time during the game.", width/2, height/35);
    text("'/' or '?' rotates the table forward - '.' or '>' rotates it backward - 'z' or 'Z' zoom in - 'x' or 'X' zoom out", width/2, height/14);
    text("Press shift + 1-3 for 3 levels of AI dificulty - 'F1,F2,F3,F4' for players choice", width/2, height/9);
    //text("( 0 - 2 )",width/1.8,height/8);
    //fill(255);
  } else {
    textSize(24);
    fill(120, 120, 0);
    //textAlign(CENTER);
    switch (level) {
    case 3:
      text("AI Level = High", width/2, height/20);
      break;
    case 2:
      text("AI Level = Medium", width/2, height/20);
      break;
    case 1:
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
    zTranslate += 0.5f;
} else if (keys[5]) {
    zTranslate -= 0.5f;
}

if (keys[6]) {
    xRotate += 0.005f;
} else if (keys[7]) {
    xRotate -= 0.005f;
}
//}

  ball.edges();
  ball.update();
  ball.show();
  //popMatrix();

  if (fire) {
    ps.addParticle(ball.x, ball.y, ball.z-22);//random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
    ps.run();
  }
}

public void keyPressed() {
  //print(keyCode);
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

  if (key == 'r' || key == 'R') {
    ball.reset();  
    ball.xspeed = -10;
  } else if (key =='l' || key == 'L') {
    ball.reset();  
    ball.xspeed = 10;

    if (level == 1) {
      aiSpeedR = random(5, 7);
      aiSpeedL = random(1, 3);
    } else if (level == 2) {
      aiSpeedR = random(6, 8);
      aiSpeedL = random(1, 3);
    } else if (level == 3) {
      aiSpeedR = random(7, 9);
      aiSpeedL = random(1, 3);
    }
  } 

  if (key == '/' || key == '?') {
    keys[6] = true;
    //xRotate += 0.01;
  } else if (key == '.' || key == '>') {
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

public void keyReleased() {
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
  
  if (key == '/' || key == '?') {
    keys[6] = false;
  } else if (key == '.' || key == '>') {
    keys[7] = false;
    //xRotate -= 0.03;
  }
}

//void mousePressed() {
//  mx = mouseX;
//  my = mouseY;
//  click = true;
//}

public void mouseReleased() {
  moveRight = 0;
  moveLeft = 0;
}

public void mouseDragged() {
  if (mouseY < pmouseY) {
    moveRight = - ((pmouseY - mouseY)*1.5f);
  } else if (mouseY > pmouseY) {
    moveRight = (mouseY - pmouseY)*1.5f;
  }
  
  if (mouseY < pmouseY) {
    moveLeft = - ((pmouseY - mouseY)*1.5f);
  } else if (mouseY > pmouseY) {
    moveLeft = (mouseY - pmouseY)*1.5f;
  }
}

public float moveRightAI() {
  if (aiRpad.y < ball.y-40 && aiRpad.y < ball.y+40) {
    aiYspeedR = aiSpeedR;
  } else if (aiRpad.y > ball.y-40 && aiRpad.y > ball.y+40) {
    aiYspeedR = -aiSpeedR;
  }
  return aiYspeedR;
}

public float moveLeftAI() {

  if (aiLpad.y < ball.y-40 && aiLpad.y < ball.y+40) {
    aiYspeedL = aiSpeedL;
  } else if (aiLpad.y > ball.y-40 && aiLpad.y > ball.y+40) { // (error*level)-constant  -  (error*level)+constant
    aiYspeedL = -aiSpeedL;
  }
  return aiYspeedL;
}
class Ball {
  float x;
  float y;
  float xspeed = 0;
  float yspeed = H/50;//random(-2,2);
  float rad = W/128;
  float z = rad;
  float acc = 0.2019f;
  
Ball(float W, float H){
x = W/2;
y = H/2;
}
  public void update() {
    xspeed *= 0.99802031f;
    x += xspeed;
    y += yspeed;
    if (xspeed > 11 && xspeed < 13) {
      acc -= 0.00001f;
//println("acc - "+acc);    
    } 
    else if (xspeed > 13) {
      acc -= 0.0001f;
    }
  }

  public void show() {
    stroke(255,255,0);
    //fill(0,255,0);
    pushMatrix();
    translate(x,y,-z);
    sphere(rad);
    popMatrix();
  }
  
  public void edges() {
    translate(0,0,21);
    if (y >= H-(rad*2.5f)) {
    ping.rewind();
    ping.play();
    yspeed *= -1;
    aiSpeedR *= random(0.85f,0.99f);
    aiSpeedL *= random(0.85f,0.99f);
    } else if (y <= 0+(rad*2.5f)) {
    pong.rewind();
    pong.play();
    yspeed *= -1;
    aiSpeedR *= random(0.85f,0.99f);
    aiSpeedL *= random(0.85f,0.99f);
    }

    if (x+(rad*2.5f) > W) {
     //fire = false;
     dingL.setGain(-10);
     dingL.play();
     rightBounce.play();
     startDing.pause();
     startDing.rewind();
     padR.pause();
     xspeed = 2;
     //yspeed *= 1;
     aiSpeedL = random(3);
     aiSpeedR = random(3);

     timer.countDown();
     
     if (aiLbool) {
       fill(0,255,50);
       text(ceil(timer.getTime()), W/2,H/2-5,-20);
     } else 
     {
       fill(50,170,255);
       text(ceil(timer.getTime()), W/2,H/2-5,-20);
     }
     
     if (timer.getTime() <= 0) {
     reset(); 
     } 
  } 
    else if (x-(rad*2.5f) < 0) {
     //fire = false;
     dingL.setGain(-10);
     dingL.play();
     leftBounce.play();
     startDing.pause();
     startDing.rewind();
     padL.pause();
     xspeed = -2;
     //yspeed *= 1;
     aiSpeedL = random(3);
     aiSpeedR = random(3);

     timer.countDown();

     if (aiRbool) {
       fill(255,50,50);
       text(ceil(timer.getTime()), W/2,H/2-5,-20);
     } else 
     {
       fill(255,0,255);
       text(ceil(timer.getTime()), W/2,H/2-5,-20);
     }
     if (timer.getTime() <= 0) {
     reset(); 
     }
    }
  }

  public void hitPaddleRight() {
  if (x+(rad*2.5f) >= right.x - right.w/3 && x+(rad*2.5f) < W && y+rad >= right.y - right.h/2 && y-rad <= right.y + right.h/2) {
//    println(xspeed);
    padR.play(1);
    float diff = y - (right.y - right.h/2);
    float radio = radians(105);
    float angle = map(diff, 0, right.h, -radio, radio);
    yspeed = (4+level) * sin(angle);
    xspeed *= -(1+acc);
      if (level == 1) {
        aiSpeedL = random(6,7);
      } else if(level == 2) {
        aiSpeedL = random(7,8);
      } else if (level == 3) {
        aiSpeedL = random(8,9);
      }
    padR.rewind();
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
//ps.run1();   && x+(rad*2.5) < W 
    //println(xspeed);
    } 
  } 

  public void hitRightPaddleAI() {
  if (x+(rad*2.5f) >= aiRpad.x - aiRpad.w/3 && x+(rad*2.5f) < W && y+rad >= aiRpad.y - aiRpad.h/2 && y-rad <= aiRpad.y + aiRpad.h/2) {
    padR.play(1);
    float diff = y - (aiRpad.y - aiRpad.h/2);
    float radio = radians(105);
    float angle = map(diff, 0, aiRpad.h, -radio, radio);
    yspeed = (4+level) * sin(angle);
    xspeed *= -(1+acc);
    //println(xspeed);
      if (level == 1) {
        aiSpeedL = random(6,7);
        aiSpeedR = random(1,3);
      } else if(level == 2) {
        aiSpeedL = random(7,8);
        aiSpeedR = random(1,3);
      } else if (level == 3) {
        aiSpeedL = random(8,9);
        aiSpeedR = random(1,3);
      }
    //println("L - "+aiSpeedL);
    //println("R - "+aiSpeedR);
    padR.rewind();
    //println(xspeed);
//ps1.addParticle1(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16),random(-0.1,0.1),random(-0.1,0.1),random(-0.1,0.1));
//ps.run();   x+(rad*2.5) < W && 
    } 
  } 

  public void hitPaddleLeft() {
  if (x-(rad*2.5f) <= left.x + left.w/2 && x-(rad*2.5f) > 0 && y+rad >= left.y - left.h/2 && y-rad <= left.y + left.h/2) {
    //println(xspeed);
    padL.play(1);
    float diff = y - (left.y - left.h/2);
    float radio = radians(45);
    float angle = map(diff, 0, left.h, -radio, radio);
    yspeed = (4+level) * sin(angle);
    xspeed *= -(1+acc);
    padL.rewind();
      if (level == 1) {
        aiSpeedR = random(6,7);
      } else if(level == 2) {
        aiSpeedR = random(7,8);
      } else if (level == 3) {
        aiSpeedR = random(8,9);
      }
    //println(xspeed);
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
//ps.run();   x-(rad*2.5) > 0 && 
    } 
  }

  public void hitLeftPaddleAI() {
  if (x-(rad*2.5f) <= aiLpad.x + aiLpad.w/2 && x-(rad*2.5f) > 0 && y+rad >= aiLpad.y - aiLpad.h/2 && y-rad <= aiLpad.y + aiLpad.h/2) {
    padL.play(1);
    //float diff = y - (aiLpad.y - aiLpad.h/2);
    //float radio = radians(45);
    //float angle = map(diff, 0, aiLpad.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    yspeed = (y - aiLpad.y)*0.33f;
    xspeed *= -(1+acc);
    //println(xspeed);
      if (level == 1) {
        aiSpeedR = random(6,7);
        aiSpeedL = random(1,3);
      } else if(level == 2) {
        aiSpeedR = random(7,8);
        aiSpeedL = random(1,3);
      } else if (level == 3) {
        aiSpeedR = random(8,9);
        aiSpeedL = random(1,3);
      }
    //println("L - "+aiSpeedL);
    //println("R - "+aiSpeedR);
    padL.rewind();
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(aiLpad.z-24,aiLpad.z-16));
//ps.run();    x-(rad*2.5) > 0 &&
    } 
  }

  public void reset(){
  //aiSpeedL = random(0.5,0.9);
  //aiSpeedR = random(0.5,0.9);
    if (tittle == true) {
      tittle = false;
    }
  fire = true;
  acc = 0.2019f;
  startDing.play();
  yspeed = random(-2,2);
  leftBounce.pause();
  leftBounce.rewind();
  rightBounce.pause();
  rightBounce.rewind();
  dingL.pause();
  dingL.rewind();
  dingR.pause();
  dingR.rewind();
  timer.setTime(3);
  
    if (x > W) {
      if (aiLbool) {
      leftScore++;
      }else {
      aiLscore++;
      }
      xspeed = 10;
      if (level == 1) {
        aiSpeedR = random(6,7);
        aiSpeedL = random(1,3);
      } else if(level == 2) {
        aiSpeedR = random(7,8);
        aiSpeedL = random(1,3);
      } else if (level == 3) {
        aiSpeedR = random(8,9);
        aiSpeedL = random(1,3);
      }
  } else if (x < 0) {
      if (aiRbool) {
      rightScore++;
      }else {
      aiRscore++;
      }
      xspeed = -10;
      //aiSpeedL = random(7,9);
      //aiSpeedR = random(1);
      if (level == 1) {
        aiSpeedL = random(6,7);
        aiSpeedR = random(1,3);
      } else if(level == 2) {
        aiSpeedL = random(7,8);
        aiSpeedR = random(1,3);
      } else if (level == 3) {
        aiSpeedL = random(8,9);
        aiSpeedR = random(1,3);
      }
    }
  x = W/2;   
  y = H/2;
  z =10;
  }
  
}
class ChispaSystem {

   ArrayList<Chispas> cArray;

   ChispaSystem() {
      cArray = new ArrayList<Chispas>();
   }
  
   public void addChispas(float x, float y, float z){
      cArray.add(new Chispas(x,y,z));
   }

   public void runChispas() {
      for (int i = cArray.size()-1; i >= 0; i--) {
         Chispas c = cArray.get(i);
         c.update();
         c.display();

         if (c.isDead()) {
            cArray.remove(i);
         }
      }
   }

}  
  
class Chispas {
   PVector loc;
   PVector vel;
   PVector acc;
   float lifespan = 255;
 
   Chispas(float x, float y, float z) {
      //for (int i =0; i < 1; i++) {
         vel = new PVector(random(-5,10),random(-5,10),random(5,10));
         acc = new PVector(random(-5,5),random(-5,5),5);
         loc = new PVector(x,y,z);
      //}
   }
  
   public void update(){
      vel.add(acc);
      loc.add(vel);
      lifespan -= 20;
   }
  
   public boolean isDead() {
      if (lifespan <= 0) {
         return true;
      } else {
         return false;
      }
   }

   public void display() {
      noStroke();
      fill(255,lifespan*2,0,lifespan);
      pushMatrix();
      translate(loc.x,loc.y,loc.z);
      sphere(3);
      //ellipse(loc.x,loc.y,20,15);
      popMatrix();
   }

}  
  
class Paddle {
  float x;
  float y;
  float w = W/100;
  float h = 500/8;
  float z = w;
  
  Paddle(boolean left, float W, float H) {
    if (left) {
      x = w*2; 
    } else {
      x = W - w*2;
    }
    y = H/2;//-(h/2)-ball.rad;
    }
  
  //void update() {
    
  //}
  
  public void show(){
   pushMatrix();
   translate(x, y,z/2);
   box(w,h,z);
   popMatrix();
  }
  
  public void move(float steps) {
    //if (mouseRMove) {
    //  y = steps;
    //  y = constrain(y,0+h/2,H-h/2);
    //} else 
    //{
      y += steps;
      y = constrain(y,0+h/2,H-h/2);
   // }
  }
  
}
class Particle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector col;
  
  float lifeSpan = 255;

  Particle(float px, float py, float pz, float vx, float vy, float vz) {
    for(int i = 0; i < 1;i++) {
    location = new PVector(px,py,pz);
    velocity = new PVector(vx,vy,vz);
    acceleration = new PVector(0,0,0);
    col = new PVector(255,255,0);
    }
  }
  
  public void update(){
    //acceleration.x = random(-0.1,0.1);
    velocity.add(acceleration);
    location.add(velocity);

if (ball.xspeed > 11 || ball.xspeed < -11 || (ball.xspeed < 3 && ball.xspeed > -3)) {    
    //location.x = random(ball.x-8,ball.x+4);
    //location.y = random(ball.y-8,ball.y+4);
    //location.z = random(ball.z-24,ball.z-16);
    lifeSpan -= 20;
    col.y -= 20;
} 
else if (ball.x < 0 && ball.x > W ) {
  lifeSpan = 16;
    col.y -= 20;
  } 
  else 
  {
    lifeSpan -= 40;
}
  }
  
  public boolean isDead() {
    if (lifeSpan <= 0) {
     return true;
    } else {
      return false;
    }
  }
  
  public void display() {
    //stroke(0,lifeSpan);
    //strokeWeight(2);
    pushMatrix();
    noStroke();
    fill(col.x,col.y,col.z,lifeSpan);
    //fill(255,lifeSpan);
    translate(location.x,location.y,location.z);
    sphere(8);
    popMatrix();
}
  
}
class ParticleSystem {
int inc = 0;
  ArrayList<Particle> pArray;

  ParticleSystem(){
  pArray = new ArrayList<Particle>();
    
  }

public void addParticle(float psx, float psy, float psz) {
  pArray.add(new Particle(psx,psy,psz,random(1),random(1),1));  
}


public void run() {
  for (int i = pArray.size()-1; i >= 0 ; i--) {
    Particle p = pArray.get(i); 
    p.update();
    p.display();
  
    if (p.isDead()) {
      pArray.remove(i);
inc--;
    }
  }
}

}
class Timer {

float Time;

Timer(float set) {
Time = set;
}

public float getTime() {
 return(Time); 
}

public void setTime(float set) {
 Time = set; 
}

public void countUp() {
 Time += 1/frameRate; 
}

public void countDown() {
 Time -= 1/frameRate; 
}

}
  public void settings() {  size(1200, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PingPong3D_AI" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
