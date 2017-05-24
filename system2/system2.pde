import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


// A list to store all Box objects
ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;
Box2DProcessing world;

void setup() {
  size(800,600);
  boxes = new ArrayList<Box>();
  boundaries= new ArrayList<Boundary>();
  world = new Box2DProcessing(this);
  world.createWorld();
  world.listenForCollisions();
}

void draw() {
  background(255);
  world.step();
  //[full] When the mouse is pressed, add a new Box object.
  if (mousePressed && mouseButton == LEFT) {
    Box p = new Box();
    boxes.add(p);
  }
  if (mousePressed && mouseButton == RIGHT) {
    Boundary b = new Boundary(50,10);
    boundaries.add(b);
  }
  //[end]

  //[full] Display all the Box objects.
  for (Box b: boxes) {
    b.display();
  }
  for (Boundary p: boundaries) {
    p.display();
  }
  //[end]
}