/////////////////////////////////
// PROJET SYSTEME A PARTICULES //
// enuts - 05/2017             //
/////////////////////////////////

// inspiré par Nature of Code de Daniel Shiffman
// http://natureofcode.com

// Particule ayant une masse et étant attirée par les attracteurs
class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  boolean delete = false;

  Particle(float r_, float x, float y) {
    r = r_;
    makeBody(x,y);
    body.setUserData(this);
  }

  void applyForce(Vec2 v) {
    body.applyForce(v, body.getWorldCenter());
  }

  void delete(){
    delete=true;
  }
  
  boolean done() {
    if (delete) {
      killBody();
      return true;
    }
    return false;
  }
  
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle()+90;
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(255);
    stroke(255);
    strokeWeight(2);
    ellipse(0,0,r,r);
    //beginShape(TRIANGLES);
    //vertex(0, -r*0.5);
    //vertex(-r*0.5, r*0.5);
    //vertex(r*0.5, r*0.5);
    //endShape();
    popMatrix();
  }
  
  void makeBody(float x, float y){
    // Define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;

    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 5;
    fd.friction = 1;
    fd.restitution = 0.75;

    body.createFixture(fd);

    //body.setLinearVelocity(new Vec2(0,0));
    body.setLinearVelocity(new Vec2(random(-1,1),random(-1,1)));
    body.setAngularVelocity(0);
  }
  
  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
}