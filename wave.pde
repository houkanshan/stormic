class Wave {
  float maxLoudLess = 700;
  float amp = 50;
  int[] lines;
  int linesCount = 4;
  float loudLess;
  color strokeColor;
  int lengthPerLine = 1;

  AudioPlayer song;

  Wave(AudioPlayer _song) {
    song = _song;

    lengthPerLine = ceil(width / float(song.bufferSize()));
    println(lengthPerLine);

    lengthPerLine = 2;

    initLines();

    if (theme == "black") {
      strokeColor = black;
    } else {
      strokeColor = mineShaft;
    }
  }

  void run() {
    update();
    render();
  }

  void update() {
    loudLess = min(getLoudLess(), maxLoudLess);
  }

  void render() {
    float alpha = min(254, loudLess / 500 * 255);
    stroke(strokeColor, alpha);
    // we draw the waveform by connecting neighbor values with a line
    // we multiply each of the values by 50 
    // because the values in the buffers are normalized
    // this means that they have values between -1 and 1. 
    // If we don't scale them up our waveform 
    // will look more or less like a straight line.
    Boolean nowLeft;
    AudioBuffer wave;
    for(int i = 0; i < song.bufferSize() - 1; i++) {
      nowLeft = true;
      for (int line : lines) {
        if (nowLeft) {
          wave = song.left;
        } else {
          wave = song.right;
        }
        nowLeft = !nowLeft;

        line(i * lengthPerLine, line + wave.get(i)*amp,
            (i+1) * lengthPerLine, line + wave.get(i+1)*amp);
      }
    }
  }

  void initLines() {
    lines = new int[linesCount];

    for (int i = 0; i < linesCount; ++i) {
      lines[i] = height * (i + 1) / (linesCount + 1);
    }
  }

  float getLoudLess() {
    float loudLess = 0;
    AudioBuffer wave = song.mix;
    int ilen = song.bufferSize();
    for(int i = 0; i < ilen; i++) {
      loudLess += abs(wave.get(i));
    }
    return loudLess;
  }
}
