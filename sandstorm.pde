import java.util.concurrent.CopyOnWriteArrayList;

class Sandstorm {

  CopyOnWriteArrayList<Sand> sands;
  float pushSpeed = 0;

  Sandstorm () {
    sands = new CopyOnWriteArrayList<Sand>(); 
  }

  void run() {
    for (Sand b : sands) {
      b.run(sands);
    }
    for (Sand b : sands) {
      if (!b.isAlive) {
        sands.remove(b);
      }
    }
  }

  void addSand(Sand b) {
    sands.add(b);
  }
}
