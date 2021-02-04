class Ball {
  float x;
  float y;
  float xspeed = 0;
  float yspeed = H/50;//random(-2,2);
  float rad = W/128;
  float z = rad;
  float acc = 0.00;//0.2019;
  
Ball(float Width, float Height){
x = Width/2;
y = Height/2;
}
  void update() {
    xspeed *= 0.999;
    x += xspeed;
    y += yspeed;
    //println(xspeed);
//    if (xspeed > 11 && xspeed < 13) {
//      acc -= 0.00001;
//println(xspeed);    
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
    textSize(32);
    translate(0,0,21);
    
    if (y >= H-(rad*2.5)) {
      ping.rewind();
      ping.play();
      yspeed *= -1;
      
    if (level == 1) {
      aiIncL += random(0.5);
      aiIncR += random(0.5);
    } else if (level == 2) {
      aiIncL += random(1);
      aiIncR += random(1);
    } else if (level == 3) {
      aiIncL += random(1.5);
      aiIncR += random(1.5);
    } else if (level == 4) {
      aiIncL += random(2);
      aiIncR += random(2);
    }
      float count = random(5,10);
      for (int n = 0; n < count; n++) {
      cs.addChispas(x,y,255,255,0);
      }
    } else if (y <= 0+(rad*2.5)) {
      pong.rewind();
      pong.play();
      yspeed *= -1;
    if (level == 1) {
      aiIncL += random(0.5);
      aiIncR += random(0.5);
    } else if (level == 2) {
      aiIncL += random(1);
      aiIncR += random(1);
    } else if (level == 3) {
      aiIncL += random(1.5);
      aiIncR += random(1.5);
    } else if (level == 4) {
      aiIncL += random(2);
      aiIncR += random(2);
    }
      float count = random(5,10);
      for (int n = 0; n < count; n++) {
      cs.addChispas(x,y,255,255,0);
      }
    }
pushMatrix();
  if (zRotate > 1) {
translate(width*0.195,height*1.06,0);
  textSize(height*0.2);
  }else
  textSize(height*0.096);
  rotateX(0);
  rotateY(0);
  rotateZ(-zRotate);
    if (x+(rad*2.5) > W+100) {
     //fire = false;
     //dingL.(-10);
     dingR.play();
     rightBounce.play();
     startDing.pause();
     startDing.rewind();
     padR.pause();
     xspeed = 2;
     //yspeed *= 1;
     aiIncL = random(3);
     aiIncR = random(3);

     timer.countDown();
     
     if (aiLbool) {
       fill(0,200);
       text(ceil(timer.getTime()),W/2,H/2-5,-20);
       fill(0,255,50);
       text(ceil(timer.getTime()), W/2,H/2-5,0);
      if (gotPoint) {
      leftScore++;
      gotPoint = false;
      }
     } else 
     {
       fill(0,200);
       text(ceil(timer.getTime()),W/2,H/2-5,-20);
       fill(50,170,255);
       text(ceil(timer.getTime()), W/2,H/2-5,0);
       if (gotPoint) {
      aiLscore++;
      gotPoint = false;
      }
    }
     
     if (timer.getTime() <= 0) {
     serve(); 
      gotPoint = true;
   } 
  } 
    else if (x+(rad*2.5) < -100) {
     //fire = false;
     //dingL.setGain(-10);
     dingL.play();
     leftBounce.play();
     //startDing.pause();
     //startDing.rewind();
     //padL.pause();
     xspeed = -2;
     //yspeed *= 1;
     aiIncL = random(3);
     aiIncR = random(3);

     timer.countDown();

     if (aiRbool) {
       fill(0,200);
       text(ceil(timer.getTime()),W/2,H/2-5,-20);
       fill(255,50,50);
       text(ceil(timer.getTime()), W/2,H/2-5,0);
      if (gotPoint) {
      rightScore++;
      gotPoint = false;
      }
     } else 
     {
       fill(0,200);
       text(ceil(timer.getTime()),W/2,H/2-5,-20);
       fill(255,0,255);
       text(ceil(timer.getTime()), W/2,H/2-5,0);
      if (gotPoint) {
      aiRscore++;
      gotPoint = false;
      }
     }
     if (timer.getTime() <= 0) {
     serve(); 
     gotPoint = true;
     }
    }
    
popMatrix();
  }
  
  void hitPaddleRight() {
  if (x+(rad*2.5) >= right.x - right.w/3 && x+(rad*2.5) < right.x+(abs(xspeed)) && y+rad >= right.y - right.h/2 && y-rad <= right.y + right.h/2) {
//  if (x+(rad) >= right.x - right.w/3 && x+(rad) < W+50 && y+rad >= right.y - right.h/2 && y-rad <= right.y + right.h/2) {
//    println(xspeed);
    padR.play();
    //float diff = y - (right.y - right.h/2);
    //float radio = radians(105);
    //float angle = map(diff, 0, right.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    //xspeed *= -(1+acc);
    yspeed = ((y - right.y)*0.175);
    xspeed *= -1.09;
    //println(xspeed);
      if (level == 1) {
      aiIncL = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
        //aiIncR = iniPadSpeed;
      } else if (level == 2) {
      aiIncL = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
        //aiIncR = iniPadSpeed*1.2;
      } else if (level == 3) {
      aiIncL = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
      } else if (level == 4) {
      aiIncL = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
      }
    padR.rewind();
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
//ps.run1();   && x+(rad*2.5) < W 
    //println(xspeed);
      float count = random(5,15);
      for (int n = 0; n < count; n++) {
      cs.addChispas(x,y,255,255,0);
      }
    } 
  } 

  void hitRightPaddleAI() {
  if (x+(rad*2.5) >= aiRpad.x - aiRpad.w/3 && x+(rad*2.5) < aiRpad.x+(abs(xspeed)) && y+rad >= aiRpad.y - aiRpad.h/2 && y-rad <= aiRpad.y + aiRpad.h/2) {
  //if (x+(rad) >= aiRpad.x - aiRpad.w/2 && x < W+50 && y+rad >= aiRpad.y - aiRpad.h/2 && y-rad <= aiRpad.y + aiRpad.h/2) {
    padR.play();
    randomIncR = random(0.1,0.5);
    //float diff = y - (aiRpad.y - aiRpad.h/2);
    //float radio = radians(105);
    //float angle = map(diff, 0, aiRpad.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    //xspeed *= -1.001;
    yspeed = ((y - aiRpad.y)*0.175);
    xspeed *= -1.09;
    //println(xspeed);
      if (level == 1) {
      aiIncL = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
        //aiIncR = iniPadSpeed;
      } else if (level == 2) {
      aiIncL = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
        //aiIncR = iniPadSpeed*1.2;
      } else if (level == 3) {
      aiIncL = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
      } else if (level == 4) {
      aiIncL = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
      }
      aiIncR = random(0, 3);
    //println("L - "+aiIncL);
    //println("R - "+aiIncR);
    //println();
    padR.rewind();
//ps1.addParticle1(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16),random(-0.1,0.1),random(-0.1,0.1),random(-0.1,0.1));
//ps.run();   x+(rad*2.5) < W && 
      float count = random(5,15);
      for (int n = 0; n < count; n++) {
      cs.addChispas(x,y,255,0,0);
      }
    } 
  } 

  void hitPaddleLeft() {
  if (x-(rad*2.5) <= left.x + left.w/2 && x-(rad*2.5) > left.x-(abs(xspeed)) && y+rad >= left.y - left.h/2 && y-rad <= left.y + left.h/2) {
  //if (x-(rad) <= left.x + left.w/2 && x-(rad) > -50 && y+rad >= left.y - left.h/2 && y-rad <= left.y + left.h/2) {
    //println(xspeed);
    padL.play();
    //float diff = y - (left.y - left.h/2);
    //float radio = radians(45);
    //float angle = map(diff, 0, left.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    //xspeed *= -(1+acc);
    yspeed = (y - left.y)*0.175;
    xspeed *= -1.09;
    //println(xspeed);
    padL.rewind();
      if (level == 1) {
      aiIncR = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
      } else if (level == 2) {
      aiIncR = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
      } else if (level == 3) {
      aiIncR = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
      } else if (level == 4) {
      aiIncR = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
      }
    //println(xspeed);
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(ball.z-24,ball.z-16));
//ps.run();   x-(rad*2.5) > 0 && 
      float count = random(5,15);
      for (int n = 0; n < count; n++) {
      cs.addChispas(x,y,255,0,0);
      }
    } 
  }

  void hitLeftPaddleAI() {
  if (x-(rad*2.5) <= aiLpad.x + aiLpad.w/2 && x-(rad*2.5) > aiLpad.x-(abs(xspeed)) && y+rad >= aiLpad.y - aiLpad.h/2 && y-rad <= aiLpad.y + aiLpad.h/2) {
  //if (x-(rad) <= aiLpad.x + aiLpad.w/2 && x > -50 && y+rad >= aiLpad.y - aiLpad.h/2 && y-rad <= aiLpad.y + aiLpad.h/2) {
    padL.play();
    randomIncL = random(0.1,0.5);
    //float diff = y - (aiLpad.y - aiLpad.h/2);
    //float radio = radians(45);
    //float angle = map(diff, 0, aiLpad.h, -radio, radio);
    //yspeed = (4+level) * sin(angle);
    yspeed = ((y - aiLpad.y)*0.175);
    xspeed *= -1.09;
    //println(xspeed);
      if (level == 1) {
      aiIncR = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
      } else if (level == 2) {
      aiIncR = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
      } else if (level == 3) {
      aiIncR = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
      } else if (level == 4) {
      aiIncR = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
      }
      aiIncL = random(0, 3);
    //println("R - "+aiIncR);
    //println("L - "+aiIncL);
    //println();
    padL.rewind();
//ps.addParticle(random(ball.x-8,ball.x+4),random(ball.y-8,ball.y+4),random(aiLpad.z-24,aiLpad.z-16));
//ps.run();    x-(rad*2.5) > 0 &&
      float count = random(5,15);
      for (int n = 0; n < count; n++) {
      cs.addChispas(x,y,255,0,0);
      }
    } 

}

  void serve(){
  //aiIncL = random(0.5,0.9);
  //aiIncR = random(0.5,0.9);
    if (tittle == true) {
      tittle = false;
    }
  
  acc = 0.2020;
  startDing.pause();
  startDing.rewind();
  startDing.play();
  yspeed = random(-3,3);
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
      //if (aiLbool) {
      //leftScore++;
      //}else {
      //aiLscore++;
      //}
      xspeed = iniXSpeed;
      if (level == 1) {
      aiIncR = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
      } else if (level == 2) {
      aiIncR = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
      } else if (level == 3) {
      aiIncR = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
      } else if (level == 4) {
      aiIncR = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
      }
      aiIncL = random(0, 3);
  } else if (x < 0) {
      //if (aiRbool) {
      //rightScore++;
      //}else {
      //aiRscore++;
      //}
      xspeed = -iniXSpeed;
      //aiIncL = random(7,9);
      //aiIncR = random(1);
      if (level == 1) {
      aiIncL = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
      } else if (level == 2) {
      aiIncL = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
      } else if (level == 3) {
      aiIncL = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
      } else if (level == 4) {
      aiIncL = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
      }
      aiIncR = random(0, 3);
    }
  x = W/2;   
  y = H/2;
  z =10;
  }
}
