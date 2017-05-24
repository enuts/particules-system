class Box  {

  //[full] Our Box object has an x,y location and a width and a height.
  Body body;  
  float w,h;
  //[end]

  Box() {

    w = 16;
    h = 16;
    // Build body.
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.coordPixelsToWorld(mouseX,mouseY));
    body = world.createBody(bd);

    // Build shape.
    PolygonShape ps = new PolygonShape();
    //[full] Box2D considers the width and height of a rectangle to be the distance from the center to the edge (so half of what we normally think of as width or height).
    float box2dW = world.scalarPixelsToWorld(w/2);
    float box2dH = world.scalarPixelsToWorld(h/2);
    //[end]
    ps.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    // Set physics parameters.
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach the Shape to the Body with the Fixture.
    body.createFixture(fd);
    
    // "this" refers to this Particle object.
    // We are telling the Box2D Body to store a
    // reference to this Particle that we can
    // access later.
    body.setUserData(this);  //[bold]
    
  }

  void display() {
    //[full] We need the Body’s location and angle.
    Vec2 pos = world.getBodyPixelCoord(body);
    float a = body.getAngle();
    //[end]

    pushMatrix();
    //[full] Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(pos.x,pos.y);
    rotate(-a);
    //[end]
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  
  // This function removes a body from the Box2D world.
  void killBody() {
    world.destroyBody(body);
  }
}