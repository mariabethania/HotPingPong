class Paddle {
  float x;
  float y;
  //float yMouse;
  float w = W/90;
  float h = H/7.5;
  float z = w*1.5;
  
  Paddle(boolean left, float W, float H) {
    if (left) {
      x = w*2; 
    } else {
      x = W - w*2;
    }
    y = H/2;//-(h/2)-ball.rad;
    //yMouse = mouseY;
    }
  
  //void update() {
    
  //}
  
  void show(){
   pushMatrix();
   translate(x, y,z/2);
   strokeWeight(1);
   stroke(25);
   box(w,h,z);
   popMatrix();
  }
  
  void move(float steps) {
      //{
      y = steps;
      y = constrain(y,0+h/2,H-h/2);
      
   // }
  }
  
}
