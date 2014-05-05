import java.util.Collections;

int maxCount = 10;

class SongDirector {
  Flock flock;
  SongAnalyzer songAnalyzer;
  ArrayList<Integer> randomIndexs;

  SongDirector(SongAnalyzer _songAnalyzer, Flock _flock) {
    flock = _flock;
    songAnalyzer = _songAnalyzer;
    randomIndexs = getRandomIndexs();
  }

  void run() {
    songAnalyzer.run();

    update();

    flock.run();
  }

  void update() {
    createBoids();
  }

  void createBoids() {
    int i, ilen;

    if (!songAnalyzer.beat.beat.isKick()) { return; }

    ilen = songAnalyzer.fft.M.avgSize();
    for(i = 0; i < ilen; i++)
    {
      float y = randomIndexs.get(i);
      float amp = songAnalyzer.fft.M.getAvg(i);
      float xVel = amp;
      //float count = int(amp * maxCount / songAnalyzer.fft.maxLoudLess);
      float count = int(amp);
      println(count);

      if (count < 1) { return; }

      //for(i = 0; i < count; i++) {
        //Boid boid = new Boid(10, y, 0);
        //boid.vel.x = xVel;
        //flock.addBoid(boid);
      //}
    }

    //ilen = songAnalyzer.fft.R.specSize();
    //for(int i = 0; i < ilen; i++)
    //{
      //float y = height/2 - i;
      //float x = songAnalyzer.fft.R.getBand(i)/100;
      //if (x < 5) {
        //return;
      //}
      //Boid boid = new Boid(10, y, 0);
      //boid.vel.x = x;
    //}
  }

  ArrayList<Integer> getRandomIndexs() {
    ArrayList<Integer> indexs = new ArrayList<Integer>();
    for (int i = 0; i < songAnalyzer.fft.averages; ++i) {
      indexs.add(i);
    }
    Collections.shuffle(indexs);
    return indexs;
  }
}
