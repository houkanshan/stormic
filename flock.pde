// Modified from
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
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

  void addBoid(Boid b) {
    boids.add(b);
  }
}
