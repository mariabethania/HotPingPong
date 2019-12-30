class Chispas {
   PVector pos;
   PVector vel;
   PVector acc;
   float red,green,blue;
   float lifespan = 255;
   float rad = width*0.001;
   //float rota;
   boolean hitBool;
 
   Chispas(float x, float y,float red_,float green_, float blue_) {
      //for (int i =0; i < 1; i++) {
         pos = new PVector(x,y,0);
         vel = new PVector(random(-5,5),random(-5,5),random(10));
         acc = new PVector(0.1,0.1,0.1);
         red = red_;
         green = green_;
         blue = blue_;
         hitBool = true;
      //}
   }
  
   void update(){
      vel.add(acc);
      pos.add(vel);
      lifespan -= 20;
      //rota -= 0.1;
   }
  
   boolean isDead() {
      if (lifespan < 0) {
         return true;
      } else {
         return false;
      }
   }

   void display() {
      noStroke();
      fill(red,lifespan,blue,lifespan*2);
      pushMatrix();
      translate(pos.x,pos.y,pos.z);
      sphere(rad);
      popMatrix();
//fill(255,150,0);
//textSize(24);
//textAlign(CENTER,CENTER);
//text("+"+hitCount,pos.x,pos.y);

//popMatrix();
      //ellipse(pos.x,pos.y,rad*0.725,rad*0.75);
 }

}  
