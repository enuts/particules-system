/////////////////////////////////
// PROJET SYSTEME A PARTICULES //
// enuts - 05/2017             //
/////////////////////////////////

// inspiré par Nature of Code de Daniel Shiffman
// http://natureofcode.com

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.*;

// Le box2d world
Box2DProcessing box2d;

// Particles system
ParticleSystem sp;
// Attractor system
AttractorSystem sa;
int maxParticles = 500;
float oldMouseX;
float oldMouseY;

void setup() {
  
  size(1000,600);
  
  // Inistialisation de BOx2D
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  // No global gravity force
  box2d.setGravity(0,0);
  
  // Initialisation de 2 systèmes
  sp = new ParticleSystem(maxParticles);
  sa = new AttractorSystem(8);
  
  for(int i =0;i<maxParticles; i++) {
    sp.addParticle(random(0, width),random(0, height));
  }
}

void draw() {
  background(0);

  // Etape de Box2D
  box2d.step();
  
  // Actualisation du système de particules
  sa.run();
  
  // Actualisation du système d'attracteurs
  sp.run(sa);
  
  // Ajout de particules si on clique
  if (mousePressed && mouseButton==LEFT) {
    sp.addParticle(mouseX,mouseY);
  }
}

void mouseClicked() {
  
  // Ajout d'un attracteur sur clique droit
  if (mouseButton==RIGHT) {
    sa.clicked(mouseX, mouseY);
  }
}

void mousePressed() {
  
}

// Gérer les collisions
void beginContact(Contact cp){
  
  //On récupère les données des objets
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  // Si une particule percute un attracteur, elle meurt
  if (o1.getClass() == Particle.class && o2.getClass() == Attractor.class) {
    Particle p =(Particle) o1;
    p.delete();
    Attractor a =(Attractor) o2;
    a.changeColor(255);
  }
  
  // Et vice versa 
  if (o2.getClass() == Particle.class && o1.getClass() == Attractor.class) {
    Particle p =(Particle) o2;
    p.delete();
    Attractor a =(Attractor) o1;
    a.changeColor(255);
  } 
}

// Gérer la fin d'une collision
void endContact(Contact cp){
  
  // On récupère les infos sur les objets
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  // Sur la fin d'une collision, on change la couleur des attracteurs
  if (o2.getClass() == Attractor.class) {
    Attractor a =(Attractor) o2;
    a.changeColor(0);
  } 
  
  if (o1.getClass() == Attractor.class) {
    Attractor a =(Attractor) o1;
    a.changeColor(0);
  } 
  
}