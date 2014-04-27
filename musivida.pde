import processing.opengl.*;
import toxi.geom.*;

Boolean debug = true;

Stone stone; // tmp one

void setup() {
  //size(1024, 640, "processing.core.PGraphicsRetina2D");
  size(1024, 640, OPENGL);
  hint(ENABLE_RETINA_PIXELS);

  stone = new Stone(512, 320, 0);
  smooth();
}

void draw() {
  background(255);

  float camZ = (height/2.0) / tan(PI*60.0 / 360.0);
  camera(mouseX, mouseY, camZ,
      width/2.0, height/2.0, 0,
      0, 1, 0); 

  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);
  stone.body.rotate3D(new Vec3D(radians(1), 0, 0));
  stone.run();
}

void mousePressed() {
  stone.body.scale(2);
}
