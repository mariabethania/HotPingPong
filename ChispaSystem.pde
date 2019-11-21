class ChispaSystem {

   ArrayList<Chispas> cArray;

   ChispaSystem() {
      cArray = new ArrayList<Chispas>();
   }
  
   void addChispas(float x, float y, float z){
      cArray.add(new Chispas(x,y,z));
   }

   void runChispas() {
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
  
