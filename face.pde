
class Face {
  Vec3D a;
  Vec3D b;
  Vec3D c;
  Vec3D ab;
  Vec3D ac;
  
  float normalLength = 0;
  float amp = 0;

  Shadow sab = new Shadow();
  Shadow sbc = new Shadow();
  Shadow sca = new Shadow();

  color ccolor = white;

  // for texture
  PImage img = loadImage("paint_color_s.png");
  Vec2D ta = new Vec2D(0, 0);
  Vec2D tb = new Vec2D(0, 100);
  Vec2D tc;

  Vec3D angle3D = new Vec3D();

  Face(Vec3D _a, Vec3D _b, Vec3D _c) {
    a = _a;
    b = _b;
    c = _c;
    updateLines();
    updateTexture();
    updateShadows();
  }

  void update() {
    updateLines();
    //updateShadows();
    //updateTexture();
  }

  void render() {
    renderShape();
    //renderNormalLine(); // ugly.
    if (debug) {
      renderSkeleton();
    }
    renderShadows();
  }

  void updateLines() {
    ab = b.sub(a);
    ac = c.sub(a);
  }

  void updateTexture() {
    float bac = ac.angleBetween(ab, true);
    float _bc = ab.magnitude();
    tc = new Vec2D(_bc * sin(bac), _bc * cos(bac));
  }

  void updateShadows() {
    sab.updateVec(a, b, c);
    sbc.updateVec(b, c, a);
    sca.updateVec(c, a, b);
  }

  void renderShadows() {
    sab.render();
    sbc.render();
    sca.render();
  }

  void renderSkeleton() {
    lineV(a);
    lineV(b);
    lineV(c);
  }

  void renderNormalLine() {
    lineV(getNormalVector().scaleSelf(normalLength));
  }

  void renderShape() {
    beginShape();
    stroke(0);

    tint(ccolor);
    fill(254);
    texture(img);
    shapeV(a, ta);
    shapeV(b, tb);
    shapeV(c, tc);
    endShape(CLOSE);
  }

  void setColor(color _color) {
    ccolor = _color;
  }

  Vec3D getNormalVector() {
    return Vec3DHelper.normalVector(ac, ab);
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
