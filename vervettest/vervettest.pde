//[full] Importing the libraries
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
//[end]

VerletPhysics2D physics;
ArrayList<Particle> particles;

void setup() {
  size(800,600);
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  particles = new ArrayList<Particle>();
  
  float len = 10;
  float numParticles = 20;
  for(int i=0; i < numParticles; i++) {
    // Spacing them out along the x-axis
    Particle particle=new Particle(new Vec2D(i*len,10));
    // Add the particle to our list.
    physics.addParticle(particle);
    // Add the particle to the physics world.
    particles.add(particle);
    
    if (i != 0) {
      // First we need a reference to the previous particle.
      Particle previous = particles.get(i-1);
    
      //[offset-down] Then we make a spring connection between the particle and the previous particle with a rest length and strength (both floats).
      VerletSpring2D spring = new VerletSpring2D(particle,previous,len,1);  
    
      // We must not forget to add the spring to the physics world.
      physics.addSpring(spring);
    }
  }
  
  Particle head = particles.get(0);
  head.lock();
}

void draw() {
  // This is the same as Box2D’s “step()” function
  physics.update();
  
  background(255);

  // Drawing everything
  stroke(0);
  noFill();
  beginShape();
  for(Particle p : particles){
    vertex(p.x,p.y);
  }
  endShape();
}