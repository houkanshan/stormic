// Modified from
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids
import java.util.concurrent.CopyOnWriteArrayList;

class Flock {
  CopyOnWriteArrayList<Boid> boids; // An ArrayList for all the boids
  Boolean speedLimit = true;
  float pushSpeed = 0;

  Flock() {
    boids = new CopyOnWriteArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.speedLimit = speedLimit;
      if (!speedLimit) {
        b.vel.normalizeTo(pushSpeed);
      }
      b.run(boids);
    }
    for (Boid b : boids) {
      if (!b.isAlive) {
        boids.remove(b);
      }
    }
  }

  void forceSpeed(float speed) {
    speedLimit = false;
    pushSpeed = speed;
  }

  void stopSpeedForce() {
    speedLimit = true;
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}
