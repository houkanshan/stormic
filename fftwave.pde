import ddf.minim.analysis.*;
 
class FFTWave {

  AudioPlayer song;
  FFT fft;
  float amp = width/2;
  

  FFTWave(AudioPlayer _song) {
    song = _song;
    fft = new FFT(song.bufferSize(), song.sampleRate());
  }

  void run() {
    update();
    render();
  }

  void update() {
    fft.forward(song.mix);
  }

  void render() {
    // first perform a forward fft on one of song's buffers
    // I'm using the mix buffer
    //  but you can use any one you like
    stroke(255, 0, 0, 128);
    // draw the spectrum as a series of vertical lines
    // I multiple the value of getBand by 4 
    // so that we can see the lines better
    for(int i = 0; i < fft.specSize(); i++)
    {
      //line(i, amp, i, amp - fft.getBand(i)*4);
      line(0, i,
          fft.getBand(i)*4, i);
    }
  }
}
