// Modified from
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids
import java.util.concurrent.CopyOnWriteArrayList;

class Flock {
  CopyOnWriteArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new CopyOnWriteArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);
    }
    for (Boid b : boids) {
      if (!b.isAlive) {
        boids.remove(b);
      }
    }
  }

  void forceSpeed(float speed) {
    for (Boid b : boids) {
      b.speedLimit = false;
      b.vel = b.vel.normalizeTo(speed);
    }
  }

  void stopSpeedForce() {
    for (Boid b : boids) {
      b.speedLimit = true;
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}
