import processing.opengl.*;
import toxi.geom.*;

Boolean debug = true;

Flock flock;

void setup() {
  //size(1024, 640, "processing.core.PGraphicsRetina2D");
  size(1024, 640, OPENGL);
  hint(ENABLE_RETINA_PIXELS); // useless..

  flock = new Flock();
  for (int i = 0; i < 120; i++) {
    flock.addBoid(new Boid(10, random(10, height - 10), 0));
  }

  smooth();
}

void draw() {
  background(255);

  float camZ = (height/2.0) / tan(PI*60.0 / 360.0);
  camera(mouseX, mouseY, camZ,
      width/2.0, height/2.0, 0,
      0, 1, 0); 

  // TODO
  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);

  flock.run();
}
