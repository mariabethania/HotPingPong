class Ball {
  float x;
  float y;
  float xspeed = 0;
  float yspeed = H/50;//random(-2,2);
  float rad = W/128;
  float z = rad;
  float acc = 0.00;//0.2019;
  
Ball(float W, float H){
x = W/2;
y = H/2;
}
  void update() {
    //xspeed *= 0.99802031;
    x += xspeed;
    y += yspeed;
//    if (xspeed > 11 && xspeed < 13) {
//      acc -= 0.00001;
////println("acc - "+acc);    
//    } 
//    else if (xspeed > 13) {
//      acc -= 0.0001;
//    }
  }

  void show() {
    stroke(255,255,0);
    //fill(0,255,0);
    pushMatrix();
    translate(x,y,-z);
    sphere(rad);
    popMatrix();
  }
  
  void edges() {
    translate(0,0,21);
    if (y >= H-(rad*2.5)) {
    ping.rewind();
    ping.play();
    yspeed *= -1;
    aiSpeedR *= random(1.1,1.2);
    aiSpeedL *= random(01.1,1.2);
    } else if (y <= 0+(rad*2.5)) {
    pong.rewind();
    pong.play();
    yspeed *= -1;
    aiSpeedR *= random(1.1,1.2);
    aiSpeedL *= random(1.1,1.2);
    }

    if (x+(rad*2.5) > W) {
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
     serve(); 
     } 
  } 
    else if (x-(rad*2.5) < 0) {
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
     serve(); 
     }
    }
  }

  void hitPaddleRight() {
  if (x+(rad*2.5) >= right.x - right.w/3 && x+(rad*2.5) < W && y+rad >= right.y - right.h/2 && y-rad <= right.y + right.h/2) {
//    println(xspeed);
    padR.play(1);
    //float diff = y - (right.y - right.h/2);
    //float radio = radians(105);
    //float angle = map(diff, 0, right.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    //xspeed *= -(1+acc);
    yspeed = (y - right.y)*0.175;
    xspeed *= -1.005;
    println(xspeed);
    if (level == 1) {
      aiSpeedL = random(6, 8);
      //aiSpeedR = random(0, 3);
    } else if (level == 2) {
      aiSpeedL = random(7, 9);
      //aiSpeedR = random(0, 3);
    } else if (level == 3) {
      aiSpeedL = random(8, 10);
      //aiSpeedR = random(0, 3);
    }
    padR.rewind();
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
//ps.run1();   && x+(rad*2.5) < W 
    //println(xspeed);
    } 
  } 

  void hitRightPaddleAI() {
  if (x+(rad*2.5) >= aiRpad.x - aiRpad.w/3 && x+(rad*2.5) < W && y+rad >= aiRpad.y - aiRpad.h/2 && y-rad <= aiRpad.y + aiRpad.h/2) {
    padR.play(1);
    //float diff = y - (aiRpad.y - aiRpad.h/2);
    //float radio = radians(105);
    //float angle = map(diff, 0, aiRpad.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    //xspeed *= -1.001;
    yspeed = (y - aiRpad.y)*0.175;
    xspeed *= -1.005;
    println(xspeed);
    //println(xspeed);
    if (level == 1) {
      aiSpeedL = random(6, 8);
      aiSpeedR = random(0, 3);
    } else if (level == 2) {
      aiSpeedL = random(7, 9);
      aiSpeedR = random(0, 3);
    } else if (level == 3) {
      aiSpeedL = random(8, 10);
      aiSpeedR = random(0, 3);
    }
    //println("L - "+aiSpeedL);
    //println("R - "+aiSpeedR);
    padR.rewind();
//ps1.addParticle1(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16),random(-0.1,0.1),random(-0.1,0.1),random(-0.1,0.1));
//ps.run();   x+(rad*2.5) < W && 
    } 
  } 

  void hitPaddleLeft() {
  if (x-(rad*2.5) <= left.x + left.w/2 && x-(rad*2.5) > 0 && y+rad >= left.y - left.h/2 && y-rad <= left.y + left.h/2) {
    //println(xspeed);
    padL.play(1);
    //float diff = y - (left.y - left.h/2);
    //float radio = radians(45);
    //float angle = map(diff, 0, left.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    //xspeed *= -(1+acc);
    yspeed = (y - left.y)*0.175;
    xspeed *= -1.005;
    println(xspeed);
    padL.rewind();
    if (level == 1) {
      aiSpeedR = random(6, 8);
      //aiSpeedL = random(0, 3);
    } else if (level == 2) {
      aiSpeedR = random(7, 9);
      //aiSpeedL = random(0, 3);
    } else if (level == 3) {
      aiSpeedR = random(8, 10);
      aiSpeedL = random(0, 3);
    }
    //println(xspeed);
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
//ps.run();   x-(rad*2.5) > 0 && 
    } 
  }

  void hitLeftPaddleAI() {
  if (x-(rad*2.5) <= aiLpad.x + aiLpad.w/2 && x-(rad*2.5) > 0 && y+rad >= aiLpad.y - aiLpad.h/2 && y-rad <= aiLpad.y + aiLpad.h/2) {
    padL.play(1);
    //float diff = y - (aiLpad.y - aiLpad.h/2);
    //float radio = radians(45);
    //float angle = map(diff, 0, aiLpad.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    yspeed = (y - aiLpad.y)*0.175;
    xspeed *= -1.005;
    println(xspeed);
    if (level == 1) {
      aiSpeedR = random(6, 8);
      aiSpeedL = random(0, 3);
    } else if (level == 2) {
      aiSpeedR = random(7, 9);
      aiSpeedL = random(0, 3);
    } else if (level == 3) {
      aiSpeedR = random(8, 10);
      aiSpeedL = random(0, 3);
    }
    //println("L - "+aiSpeedL);
    //println("R - "+aiSpeedR);
    padL.rewind();
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(aiLpad.z-24,aiLpad.z-16));
//ps.run();    x-(rad*2.5) > 0 &&
    } 

}

  void serve(){
  //aiSpeedL = random(0.5,0.9);
  //aiSpeedR = random(0.5,0.9);
    if (tittle == true) {
      tittle = false;
    }
  fire = true;
  acc = 0.2020;
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
      aiSpeedR = random(6, 8);
      aiSpeedL = random(0, 3);
    } else if (level == 2) {
      aiSpeedR = random(7, 9);
      aiSpeedL = random(0, 3);
    } else if (level == 3) {
      aiSpeedR = random(8, 10);
      aiSpeedL = random(0, 3);
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
      aiSpeedL = random(6, 8);
      aiSpeedR = random(0, 3);
    } else if (level == 2) {
      aiSpeedL = random(7, 9);
      aiSpeedR = random(0, 3);
    } else if (level == 3) {
      aiSpeedL = random(8, 10);
      aiSpeedR = random(0, 3);
    }
    }
  x = W/2;   
  y = H/2;
  z =10;
  }
  
}
