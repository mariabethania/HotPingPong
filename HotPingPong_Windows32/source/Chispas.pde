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
  
   void update(){
      vel.add(acc);
      loc.add(vel);
      lifespan -= 20;
   }
  
   boolean isDead() {
      if (lifespan <= 0) {
         return true;
      } else {
         return false;
      }
   }

   void display() {
      noStroke();
      fill(255,lifespan*2,0,lifespan);
      pushMatrix();
      translate(loc.x,loc.y,loc.z);
      sphere(3);
      //ellipse(loc.x,loc.y,20,15);
      popMatrix();
   }

}  
  
