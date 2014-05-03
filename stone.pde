class Stone {

  ArrayList<Vec3D> vecs;
  ArrayList<Face> faces = new ArrayList<Face>();

  Vec3D jitterSize = new Vec3D(3, 3, 3);
  Boolean jitterOn = true;

  float size = 100;
  float minSize = 30;
  float maxSize = 300;

  color ccolor = color(254, 254, 254);

  Stone(ArrayList<Vec3D> _vecs) {
    vecs = _vecs;
    initialize();
  }

  Stone() {
    Vec3D a = new Vec3D(1, 0, 0);
    Vec3D b = new Vec3D(1, 0, 0);
    Vec3D c = new Vec3D(1, 0, 0);
    Vec3D d = new Vec3D(1, 0, 0);

    a.scaleSelf(size);
    b.scaleSelf(size);
    c.scaleSelf(size);
    d.scaleSelf(size);

    b.rotateZ(radians(120));

    c.rotateZ(radians(120));
    c.rotateX(radians(120));

    d.rotateZ(radians(120));
    d.rotateX(-radians(120));

    vecs = new ArrayList<Vec3D>();
    vecs.add(a);
    vecs.add(b);
    vecs.add(c);
    vecs.add(d);
    initialize();
  }

  // fuck processing stupid this keyword.
  void initialize() {
    addFaces(vecs);
  }

  void update() {
    if (jitterOn) {
      shapeJitter();
      limitShape();
    }
    for(Face f: faces) {
      f.setColor(ccolor);
      f.update();
    }
  }

  void render() {
    for(Face f: faces) {
      f.render();
    }
  }

  void scale(float size) {
    for( Vec3D v : vecs ) {
      v.scaleSelf(size);
    }
  }

  void rotate3D(Vec3D angle3D) {
    for(Face f: faces) {
      f.rotate3D(angle3D);
    }
  }

  void addFaces(ArrayList<Vec3D> vecs) {
    // TODO
    faces.add(new Face(vecs.get(0),
          vecs.get(1), vecs.get(2)));
    faces.add(new Face(vecs.get(0),
          vecs.get(1), vecs.get(3)));
    faces.add(new Face(vecs.get(0),
          vecs.get(3), vecs.get(2)));
    faces.add(new Face(vecs.get(3),
          vecs.get(1), vecs.get(2)));
  }

  void shapeJitter() {
    Vec3D center = new Vec3D();
    for(Vec3D v : vecs) {
      v.jitter(jitterSize);
      center.addSelf(v);
    }

    center.scaleSelf(1.0/vecs.size());
    for(Vec3D v : vecs) {
      v.addSelf(center.getInverted());
    }
  }

  void limitShape() {
    for(Vec3D v : vecs) {
      if (v.magnitude() < minSize) {
        v.normalizeTo(minSize);
      } else {
        v.limit(maxSize);
      }
    }
  }
}
