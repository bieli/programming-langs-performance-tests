module vector3d;

import std.math;

struct Vector3D {
    double x, y, z;

    this(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    Vector3D opBinary(string op : "+")(Vector3D rhs) const {
        return Vector3D(x + rhs.x, y + rhs.y, z + rhs.z);
    }

    Vector3D opBinary(string op : "-")(Vector3D rhs) const {
        return Vector3D(x - rhs.x, y - rhs.y, z - rhs.z);
    }

    Vector3D opBinary(string op : "*")(double scalar) const {
        return Vector3D(x * scalar, y * scalar, z * scalar);
    }

    Vector3D opBinary(string op : "/")(double scalar) const {
        return Vector3D(x / scalar, y / scalar, z / scalar);
    }

    Vector3D cross(Vector3D rhs) const {
        return Vector3D(
            y * rhs.z - z * rhs.y,
            z * rhs.x - x * rhs.z,
            x * rhs.y - y * rhs.x
        );
    }

    double magnitude() const {
        return sqrt(x * x + y * y + z * z);
    }

    Vector3D normalize() const {
        double mag = magnitude();
        return mag != 0 ? this / mag : Vector3D(0, 0, 0);
    }

    double angle(Vector3D rhs) const {
        double crossMag = cross(rhs).magnitude();
        double prodMag = magnitude() * rhs.magnitude();
        return prodMag != 0 ? asin(crossMag / prodMag) : 0;
    }
}

