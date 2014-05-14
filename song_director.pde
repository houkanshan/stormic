import java.util.Collections;

int maxCount = 10;
int countDownTime = 3;

class SongDirector {
  Flock flock;
  SongAnalyzer songAnalyzer;
  Sandstorm sandstorm;
  ArrayList<Integer> randomIndexs;
  ArrayList<Integer> countDowns;
  int countDown;

  SongDirector(SongAnalyzer _songAnalyzer, Flock _flock, Sandstorm _sandstorm) {
    flock = _flock;
    sandstorm = _sandstorm;
    songAnalyzer = _songAnalyzer;
    randomIndexs = getRandomIndexs();
    countDowns = new ArrayList<Integer>(Collections.nCopies(
      songAnalyzer.fft.averages, 0));
  }

  void run() {
    songAnalyzer.run();

    update();

    flock.run();
    sandstorm.run();
  }

  void update() {
    createBoids();
    pushBoids();
    setFreqInfo();
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
      if (countDone(i)) {
        resetCount(i);
        createBoids(i);
        createSands(i);
      }
    }
  }

  Boolean countDone(int i) {
    countDowns.set(i, countDowns.get(i) - 1);
    return countDowns.get(i) <= 0;
  }
  void resetCount(int i) {
    countDowns.set(i, countDownTime);
  }

  void createBoids(int i) {

    float y = random(0, height);
    float amp = songAnalyzer.fft.M.getAvg(i);
    float xVel = amp;
    float count = int(amp * maxCount * 2 / songAnalyzer.fft.loudLess);

    if (count < 2) { return; }

    Boid boid = new Boid(10, y, 0);
    boid.vel.x = xVel;
    boid.body.freq = i;
    float size = exp(songAnalyzer.fft.loudLess / 50);
    boid.body.setOrigSize(size);
    flock.addBoid(boid);

  }

  void createSands(int i) {
    float y = random(0, height);
    float amp = songAnalyzer.fft.M.getAvg(i);
    float xVel = amp;
    float count = int(amp * maxCount * 2 / songAnalyzer.fft.loudLess);

    if (count < 1) { return; }

    Sand sand = new Sand(0, y, 0);
    sand.vel.x = xVel;
    sandstorm.addSand(sand);
  }

  void pushBoids() {
    float loudLess = songAnalyzer.fft.loudLess;
    if (loudLess < 100) {
      flock.stopSpeedForce();
      return;
    }
    flock.forceSpeed(loudLess / 60);
  }

  void setFreqInfo() {
    for(Boid b: flock.boids) {
      Stone body = b.body;
      //body.freqAmp = songAnalyzer.fft.M.getAvg(body.freq);
      body.freqAmp = songAnalyzer.fft.loudLess;
    }
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
