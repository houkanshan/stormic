
class Face {
  Vec3D a;
  Vec3D b;
  Vec3D c;
  color ccolor = color(254, 254, 254);

  PImage img = loadImage("paint_color_s.png");
  Vec2D ta = new Vec2D(0, 0);
  Vec2D tb = new Vec2D(0, 100);
  Vec2D tc;

  Vec3D angle3D = new Vec3D();

  Face(Vec3D _a, Vec3D _b, Vec3D _c) {
    a = _a;
    b = _b;
    c = _c;
  }

  void update() {
    Vec3D ab = b.sub(a);
    Vec3D ac = c.sub(a);
    float bac = ac.angleBetween(ab, true);
    float _bc = ab.magnitude();
    tc = new Vec2D(_bc * sin(bac), _bc * cos(bac));
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
    stroke(0);

    beginShape();
    tint(ccolor);
    texture(img);
    shapeV(a, ta);
    shapeV(b, tb);
    shapeV(c, tc);
    endShape(CLOSE);
  }

  void setColor(color _color) {
    ccolor = _color;
  }


  // util
  void shapeV(Vec3D v, Vec2D tv) {
    vertex(v.x, v.y, v.z, tv.x, tv.y);
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
