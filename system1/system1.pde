import java.util.Iterator;

ParticleSystem ps;
Repeller repeller;

void setup() {
  size(800,600);
  ellipseMode(RADIUS);
  smooth();
  ps = new ParticleSystem(new PVector(width/2,50));
  repeller = new Repeller(width/2,height/2);
}

void draw() {
  background(255);
  ps.addParticle();
  
  // Apply gravity force to all Particles
  PVector gravity = new PVector(0,0.1);
  ps.applyForce(gravity);
  
  ps.applyRepeller(repeller);
  
  repeller.display();
  ps.run();
}