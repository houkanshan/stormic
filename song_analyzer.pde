import ddf.minim.*;

class SongAnalyzer {
  Minim minim;
  AudioPlayer song;
  AudioInput input;
  Wave wave;
  FFTWave fft;
  Beat beat;
  Bass bass;

  SongAnalyzer(Object processing, String fileName) {
    initialize(processing, fileName);
  }

  void initialize(Object processing, String fileName) {
    minim = new Minim(processing);

    song = minim.loadFile(fileName);

    initPlayer(song);

    wave = new Wave(song);
    fft = new FFTWave(song);
    beat = new Beat(song);
    bass = new Bass(fft.M);
  }

  void run() {
    update();
    render();
  }

  void update() {
  }

  void render() {
    fft.update();
    bass.run();
    fft.render();
    beat.run();
    wave.run();
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
