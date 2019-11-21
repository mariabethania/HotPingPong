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
  
  void update(){
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
  
  boolean isDead() {
    if (lifeSpan <= 0) {
     return true;
    } else {
      return false;
    }
  }
  
  void display() {
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
