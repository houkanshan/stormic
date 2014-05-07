import java.util.Collections;

int maxCount = 10;
int countDownTime = 3;

class SongDirector {
  Flock flock;
  SongAnalyzer songAnalyzer;
  ArrayList<Integer> randomIndexs;
  ArrayList<Integer> countDowns;
  int countDown;

  SongDirector(SongAnalyzer _songAnalyzer, Flock _flock) {
    flock = _flock;
    songAnalyzer = _songAnalyzer;
    randomIndexs = getRandomIndexs();
    countDowns = new ArrayList<Integer>(Collections.nCopies(
      songAnalyzer.fft.averages, 0));
  }

  void run() {
    songAnalyzer.run();

    update();

    flock.run();
  }

  void update() {
    createBoids();
    pushBoids();
  }

  Boolean needWait() {
    if (songAnalyzer.beat.beat.isKick()) { return false; }
    if (songAnalyzer.fft.loudLess > 400) { return false; }
    if (songAnalyzer.fft.loudLess < 20) { return true; }
    countDown -= 1;
    if (countDown > 0) { return true; }
    countDown = 15;
    return false;
  }

  void createBoids() {
    if (needWait()) { return; }

    int i, ilen;

    ilen = songAnalyzer.fft.M.avgSize();
    for(i = 0; i < ilen; i++) {
      countDowns.set(i, countDowns.get(i) - 1);
      if (countDowns.get(i) > 0) { return; }

      float y = random(0, height);
      float amp = songAnalyzer.fft.M.getAvg(i);
      float xVel = amp;
      float count = int(amp * maxCount * 2 / songAnalyzer.fft.loudLess);

      if (count < 1) { continue; }

      Boid boid = new Boid(10, y, 0);
      boid.vel.x = xVel;
      boid.body.setSize(exp(songAnalyzer.fft.loudLess / 50));
      flock.addBoid(boid);

      countDowns.set(i, countDownTime);
    }
  }

  void pushBoids() {
    float loudLess = songAnalyzer.fft.loudLess;
    if (loudLess < 100) {
      flock.stopSpeedForce();
      return;
    }
    flock.forceSpeed(loudLess / 60);
  }

  ArrayList<Integer> getRandomIndexs() {
    ArrayList<Integer> indexs = new ArrayList<Integer>();
    int i;
    int ilen = songAnalyzer.fft.averages;

    for (i = 0; i < songAnalyzer.fft.averages; ++i) {
      indexs.add(i * height / ilen);
    }
    Collections.shuffle(indexs);
    return indexs;
  }
}
