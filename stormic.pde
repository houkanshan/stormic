import processing.opengl.*;
import toxi.geom.*;

Boolean debug = false;

Flock flock;
SongAnalyzer songAnalyzer;
SongDirector songDirector;
Sandstorm sandstorm;
String theme = "black";
color backgroundColor;
Boolean fullscreen = true;

Boolean recordMovie = false;

void setup() {
  //size(1024, 640, "processing.core.PGraphicsRetina2D");
  size(1024, 640, OPENGL);
  //size(displayWidth, displayHeight, OPENGL);
  //hint(ENABLE_RETINA_PIXELS); // useless..

  songAnalyzer = new SongAnalyzer(this, "song.mp3");
  flock = new Flock();
  sandstorm = new Sandstorm();
  songDirector = new SongDirector(songAnalyzer, flock, sandstorm);

  if (theme == "black") {
    backgroundColor = mineShaft;
  } else {
    backgroundColor = white;
  }

  smooth();
}
boolean sketchFullScreen() {
  return fullscreen;
}

void draw() {
  background(backgroundColor);

  //openCamera();
  openLight();
  songDirector.run();

  if (recordMovie) {
    saveFrame("dist/####.tif");
  }

}

void mousePressed() {
  songAnalyzer.toggle();
}

void openCamera() {
  float camZ = (height/2.0) / tan(PI*60.0 / 360.0);
  camera(mouseX, mouseY, camZ,
      width/2.0, height/2.0, 0,
      0, 1, 0); 
}

void openLight() {
  // TODO
  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);
}
