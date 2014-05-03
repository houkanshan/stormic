import ddf.minim.*;
 
Minim minim;
AudioPlayer song;
AudioInput input;
Wave wave;
FFTWave fftWave;
Beat beat;

class SongAnalyzer {
  SongAnalyzer(Object processing, String fileName) {
    initialize(processing, fileName);
  }

  void initialize(Object processing, String fileName) {
    minim = new Minim(processing);

    song = minim.loadFile(fileName);

    initPlayer(song);

    wave = new Wave(song);
    fftWave = new FFTWave(song);
    beat = new Beat(song);
  }

  void run() {
    update();
    render();
  }

  void update() {}

  void render() {
    wave.run();
    fftWave.run();
    beat.run();
  }

  void initPlayer(AudioPlayer song) {
    song.loop();
  }

  // Player Control
  void play() {
    song.play();
  }
  void pause() {
    song.pause();
  }
  void stop() {
    // TODO, need stop all stuff.
    pause();
    song.rewind();
  }
  void toggle() {
    if (song.isPlaying()) {
      pause();
    } else {
      play();
    }
  }
}
