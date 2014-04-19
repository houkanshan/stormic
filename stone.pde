class Stone {

  Boid body;

  Vec3D location = new Vec3D(0, 0, 0);
  Vec3D velocity = new Vec3D(0, 0, 0);
  Vec3D acceleration = new Vec3D(0, 0, 0);

  Stone() {
  }

  Stone(float x, float y, float z) {
    body = new Boid();

    location = new Vec3D(x, y, z);
  }

  void run() {
    update();
    borders();
    render();
  }

  void update() {
    body.update();
  }

  void borders() {
  }

  void render() {
    pushMatrix();

    translate(location.x, location.y, location.z);

    body.render();

    popMatrix();
  }
}
