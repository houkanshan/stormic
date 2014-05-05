class SongDirector {
  Flock flock;
  SongAnalyzer songAnalyzer;

  SongDirector(SongAnalyzer _songAnalyzer, Flock _flock) {
    flock = _flock;
    songAnalyzer = _songAnalyzer;

    for (int i = 0; i < 120; i++) {
      Boid boid = new Boid(10, random(10, height - 10), 0);
      flock.addBoid(boid);
    }
  }

  void run() {
    update();
    flock.run();
    songAnalyzer.run();
  }

  void update() {
  }
}
