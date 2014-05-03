import ddf.minim.analysis.*;

class Beat {

  AudioPlayer song;
  BeatDetect beat;

  Beat(AudioPlayer _song) {
    song = _song;
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());
    beat.setSensitivity(350);
  }

  void run() {
    update();
    render();
  }

  void update() {
    beat.detect(song.mix);//and rate as the line in
  }

  void render() {
    if (beat.isKick()){//If there is a beat it increases the size of the
      //background(0, 100, 0);
      //println("kick");
    }
    if (beat.isSnare()){
      //background(100, 0 , 0);
      //println("snare");
    }
    if (beat.isHat()){
      //background(0, 0, 100);
      //println("hat");
    }
  }
}
