import ddf.minim.analysis.*;

class FFTWave {
  float maxLoudLess = 3500;
  AudioPlayer song;
  FFT L;
  FFT R;
  FFT M;
  float amp = width/2;
  float loudLess;
  int averages = 60;
  
  FFTWave(AudioPlayer _song) {
    song = _song;
    L = new FFT(song.bufferSize(), song.sampleRate());
    L.linAverages(50);
    R = new FFT(song.bufferSize(), song.sampleRate());
    M = new FFT(song.bufferSize(), song.sampleRate());
    M.linAverages(averages); // maybe should not use.
  }

  void run() {
    update();
    render();
  }

  void update() {
    L.forward(song.left);
    R.forward(song.right);
    M.forward(song.mix);

    loudLess = min(getLoudLess(), maxLoudLess);
  }

  void render() {
    // first perform a forward fft on one of song's buffers
    // I'm using the mix buffer
    //  but you can use any one you like
    stroke(255, 0, 0, 128);
    // draw the spectrum as a series of vertical lines
    // I multiple the value of getBand by 4 
    // so that we can see the lines better
    int ilen;

    ilen = M.avgSize();
    for(int i = 0; i < ilen; i++) {
      if (i % 2 != 0) { continue; }
      float y = height/2 - i * 20;
      float x = M.getAvg(i) * 5;
      if (x < 20) { continue; }
      renderSignal(x, y);
    }

    ilen = L.avgSize();
    for(int i = 0; i < ilen; i++) {
      if (i % 2 != 0) { continue; }
      float y = height/2 + i * 20 + 50;
      float x = log(L.getAvg(i) + 1) * 50;
      if (x < 20) { continue; }
      renderSignal(x, y);
    }
  }

  float getLoudLess() {
    float loudLess = 0;
    int ilen = M.avgSize();
    for(int i = 0; i < ilen; i++) {
      loudLess += M.getAvg(i);
    }
    return loudLess;
  }

  void renderSignal(float x, float y) {
    beginShape();

    noStroke();
    fill(disco, 200);
    vertex(0, y - x/2, 0);
    vertex(0, y + x/2, 0);
    vertex(x * sqrt(3) / 2, y, 0);

    endShape(CLOSE);
  }
}
