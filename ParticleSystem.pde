class ParticleSystem {
int inc = 0;
  ArrayList<Particle> pArray;

  ParticleSystem(){
  pArray = new ArrayList<Particle>();
    
  }

void addParticle(float psx, float psy, float psz) {
  pArray.add(new Particle(psx,psy,psz,random(1),random(1),1));  
}


void run() {
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
