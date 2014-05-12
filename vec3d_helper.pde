static class Vec3DHelper {

  static Vec3D rotate3D(Vec3D v, Vec3D angle3D) {
    v.rotateX(angle3D.x);
    v.rotateY(angle3D.y);
    v.rotateZ(angle3D.z);
    return v;
  }

  static Vec3D normalVector(Vec3D l1, Vec3D l2) {
    return l1.cross(l2).normalize();
  }

}

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

void renderImage(PImage img, Vec3D _loc, float _diam, color _col, float _alpha ) {
  pushMatrix();
  translate( _loc.x, _loc.y, _loc.z );
  tint(red(_col), green(_col), blue(_col), _alpha);
  imageMode(CENTER);
  image(img,0,0,_diam,_diam);
  popMatrix();
}

