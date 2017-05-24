/////////////////////////////////
// PROJET SYSTEME A PARTICULES //
// enuts - 05/2017             //
/////////////////////////////////

// inspiré par Nature of Code de Daniel Shiffman
// http://natureofcode.com

// Ensemble de particle
class ParticleSystem {
  
  ArrayList<Particle> system;
  int maxParticles;
  ParticleSystem(int n){
    system = new ArrayList<Particle>();
    maxParticles = n;
  }
  
  void run(AttractorSystem as){
    Particle p;
    Attractor a;
    for (int j = 0; j< as.system.size(); j++){
      a = as.system.get(j);
      for (int i = 0; i < system.size(); i++) {
        // Look, this is just like what we had before!
        p = system.get(i);
        Vec2 force = a.attract(p);
        p.applyForce(force);
        p.display();
        
        if( p.done() ) {
          system.remove(p);
        }
      }
    } 
    
    for (int i = 0; i < system.size(); i++) {
      p = system.get(i);
      Vec2 force = new Vec2();
      for (int j = 0; j< as.system.size(); j++){
        // Look, this is just like what we had before!
        a = as.system.get(j);
        force = a.attract(p);
      }
      p.applyForce(force);
      p.display();
      if( p.done() ) {
        system.remove(p);
      }
    } 
    
    this.display();
  }
  
  void addParticle(float x, float y) {
    if( system.size() < maxParticles) {
      system.add(new Particle(1, x, y));
    }
  }
  
  void display(){
    fill(255);
    stroke(0);
       
    rect(0,3,width* (maxParticles-system.size())/maxParticles,10);
  }
}