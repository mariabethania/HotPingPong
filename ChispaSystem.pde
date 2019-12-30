class ChispaSystem {

   ArrayList<Chispas> chArray;

   

   ChispaSystem() {

      chArray = new ArrayList<Chispas>();

   }

   

   void addChispas(float x_,float y_,float red_,float green_, float blue_){

      chArray.add(new Chispas(x_,y_,red_,green_,blue_));

   }
   void runChispas() {
      for (int i = chArray.size()-1; i >= 0; i--) {
         Chispas ch = chArray.get(i);
         ch.update();
         ch.display();

         if (ch.isDead()) {
            chArray.remove(i);
         }
      }
   }

}
