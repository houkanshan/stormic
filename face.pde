class Face {
  Vec3D a;
  Vec3D b;
  Vec3D c;

  Vec3D angle3D = new Vec3D();

  Face(Vec3D _a, Vec3D _b, Vec3D _c) {
    a = _a;
    b = _b;
    c = _c;
  }

  void update() {
  }

  void render() {
    renderShape();
    if (debug) {
      lineV(a);
      lineV(b);
      lineV(c);
    }
  }


  void renderShape() {
    beginShape();
    shapeV(a);
    shapeV(b);
    shapeV(c);
    endShape(CLOSE);
  }

  // util
  void shapeV(Vec3D v) {
    vertex(v.x, v.y, v.z);
  }

  void lineV(Vec3D v) {
    line(0, 0, 0, v.x, v.y, v.z);
  }

  void rotate3D(Vec3D angle3D) {
    Vec3DHelper.rotate3D(a, angle3D);
    Vec3DHelper.rotate3D(b, angle3D);
    Vec3DHelper.rotate3D(c, angle3D);
  }
}
