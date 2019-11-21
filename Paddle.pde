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
  
  void show(){
   pushMatrix();
   translate(x, y,z/2);
   box(w,h,z);
   popMatrix();
  }
  
  void move(float steps) {
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
