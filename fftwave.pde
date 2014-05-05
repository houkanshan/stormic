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
    L.linAverages(averages);
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

    ilen = L.avgSize();
    for(int i = 0; i < ilen; i++) {
      float y = height/2 - i;
      line(0, y, L.getAvg(i) * 10, y);
    }

    ilen = R.specSize();
    for(int i = 0; i < ilen; i++) {
      float y = height/2 + i;
      line(0, y, R.getBand(i)*4, y);
    }
  }

  float getLoudLess() {
    float loudLess = 0;
    int ilen = M.specSize();
    for(int i = 0; i < ilen; i++) {
      loudLess += M.getBand(i);
    }
    return loudLess;
  }
}
