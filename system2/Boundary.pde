class Boundary {

  //[full] A boundary is a simple rectangle with x, y, width, and height.
  float x,y;
  float w,h;
  //[end]
  Body b;

  Boundary(float w_, float h_) {
    w = w_;
    h = h_;

    // Build the world Body and Shape.
    BodyDef bd = new BodyDef();
    bd.position.set(world.coordPixelsToWorld(mouseX,mouseY));
    // Make it fixed by setting type to STATIC!
    bd.type = BodyType.STATIC;
    b = world.createBody(bd);

    float worldW = world.scalarPixelsToWorld(w/2);
    float worldH = world.scalarPixelsToWorld(h/2);
    PolygonShape ps = new PolygonShape();
    // The PolygonShape is just a box.
    ps.setAsBox(worldW, worldH);

    // Using the createFixture() shortcut
    b.createFixture(ps,1);
  }

  // Since we know it can never move, we can just draw it
  // the old-fashioned way, using our original
  // variables. No need to query world.
  void display() {
    //[full] We need the Body’s location and angle.
    Vec2 pos = world.getBodyPixelCoord(b);
    float a = b.getAngle();
    //[end]

    pushMatrix();
    //[full] Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(pos.x,pos.y);
    rotate(-a);
    //[end]
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }

}