class Shadow {
  Vec3D a = new Vec3D();
  Vec3D b = new Vec3D();
  Vec3D c = new Vec3D();
  Vec2D ta = new Vec2D();
  Vec2D tb = new Vec2D();
  Vec2D tc = new Vec2D();
  PImage img = loadImage("shadow.png");

  Shadow() {
    initialize();
  }

  void initialize () {
    tb.x = 400;
  }

  void updateVec(Vec3D _a, Vec3D _b, Vec3D _c) {
    a = _a;
    b = _b;
    c = _c;

    float bac = b.sub(a).angleBetween(c.sub(a), true);
    float _ac = a.distanceTo(c) * 400 / b.distanceTo(c);
    tc.x = _ac * cos(bac);
    tc.y = _ac * sin(bac);
  }

  void render() {
    beginShape();
    texture(img);
    //noFill();
    shapeV(a, ta);
    shapeV(b, tb);
    shapeV(c, tc);
    endShape(CLOSE);
  }

  void shapeV(Vec3D v, Vec2D tv) {
    vertex(v.x, v.y, v.z, tv.x, tv.y);
  }
}
