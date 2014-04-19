static class Vec3DHelper {

  static Vec3D rotate3D(Vec3D v, Vec3D angle3D) {
    v.rotateX(angle3D.x);
    v.rotateY(angle3D.y);
    v.rotateZ(angle3D.z);
    return v;
  }

}
