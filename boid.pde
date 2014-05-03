// Rewrite to 3D version from:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

float swt = 25.0;     //sep.mult(25.0f);
float awt = 4.0;      //ali.mult(4.0f);
float cwt = 5.0;      //coh.mult(5.0f);
float maxspeed = 1;
float maxforce = 0.025;

class Boid {

  Stone body;

  float r = 20;

  Vec3D loc = new Vec3D(0, 0, 0);
  Vec3D vel = new Vec3D(0, 0, 0);
  Vec3D acc = new Vec3D(0, 0, 0);

  Boid(float x, float y, float z) {
    body = new Stone();

    acc = new Vec3D(0, 0, 0);
    vel = new Vec3D(random(-1,1),random(-1,1), 0);
    loc = new Vec3D(x, y, z);
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    Vec3D sep = separate(boids);   // Separation
    Vec3D ali = align(boids);      // Alignment
    Vec3D coh = cohesion(boids);   // Cohesion

    // Arbitrarily weight these forces
    sep.scaleSelf(swt);
    ali.scaleSelf(awt);
    coh.scaleSelf(cwt);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  void update() {
    // Update velocity
    vel.addSelf(acc);
    // Limit speed
    vel.limit(maxspeed);
    loc.addSelf(vel);
    // Reset accelertion to 0 each cycle
    acc.scaleSelf(0);

    body.update();
  }

  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  void render() {
    pushMatrix();

    translate(loc.x, loc.y, loc.z);
    body.render();

    popMatrix();
  }

  void applyForce(Vec3D force) {
    // We could add mass here if we want A = F / M
    acc.addSelf(force);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  Vec3D seek(Vec3D target) {
    Vec3D desired = target.sub(loc);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.normalizeTo(maxspeed);
    // Steering = Desired minus Velocity
    Vec3D steer = desired.sub(vel);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }

  // Separation
  // Method checks for nearby boids and steers away
  Vec3D separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0;
    Vec3D steer = new Vec3D(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = loc.distanceTo(other.loc);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        Vec3D diff = loc.sub(other.loc);
        diff.normalizeTo(1.0/d);
        steer.addSelf(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.scaleSelf(1.0/(float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalizeTo(maxspeed);
      steer.subSelf(vel);
      steer.limit(maxforce);
    }
    return steer;
  }


  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  Vec3D align (ArrayList<Boid> boids) {
    float neighbordist = 50.0;
    Vec3D steer = new Vec3D();
    int count = 0;
    for (Boid other : boids) {
      float d = loc.distanceTo(other.loc);

      if ((d > 0) && (d < neighbordist)) {
        steer.addSelf(other.vel);
        count++;
      }
    }
    if (count > 0) {
      steer.scaleSelf(1.0/(float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalizeTo(maxspeed);
      steer.subSelf(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  Vec3D cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50.0;
    Vec3D sum = new Vec3D(0, 0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Boid other : boids) {
      float d = loc.distanceTo(other.loc);

      if ((d > 0) && (d < neighbordist)) {
        sum.addSelf(other.loc); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1.0/(float)count);
      return seek(sum);  // Steer towards the location
    }
    return sum;
  }
}
