/////////////////////////////////
// PROJET SYSTEME A PARTICULES //
// enuts - 05/2017             //
/////////////////////////////////

// inspiré par Nature of Code de Daniel Shiffman
// http://natureofcode.com

// Ensemble d'attracteurs
class AttractorSystem {
  
  ArrayList<Attractor> system;
  int maxAttractors;
  int diam =10;
  
  AttractorSystem(int n){
    system = new ArrayList<Attractor>();
    maxAttractors = n;
  }
  
  void run(){
    Attractor a;
    for (int i = 0; i < system.size(); i++) {
      // Look, this is just like what we had before!
      a = system.get(i);
      a.display();
      
      if( a.done() ) {
        system.remove(a);
      }
    } 
    
    this.display();
  }
  
  void addAttractor(float x, float y) {
    if( system.size() < maxAttractors) {
      system.add(new Attractor(diam, x, y));
    }
  }
  
  void display(){
    fill(255);
    stroke(0);
    text(int(system.size()) + " attracteur(s)\\"+int(maxAttractors)+" ", 20, height-50);
   // rect(0,3,width* (maxParticles-system.size())/maxParticles,10);
  }
  
  void clicked(int x,int y) {
    boolean hover = false;
    float dist;
    for( Attractor a : system) {
      dist = box2d.coordWorldToPixels(a.body.getPosition()).sub(new Vec2(x, y)).length();
      if (dist <= 2*diam) {
        hover = true;
        a.delete();
      }
    }
    if(!hover) addAttractor(x,y) ; 
  }
}