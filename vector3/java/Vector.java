public class Vector {
    public double x, y, z;

    public Vector(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public Vector add(Vector other) {
        return new Vector(x + other.x, y + other.y, z + other.z);
    }

    public Vector subtract(Vector other) {
        return new Vector(x - other.x, y - other.y, z - other.z);
    }

    public Vector cross(Vector other) {
        return new Vector(
            y * other.z - z * other.y,
            z * other.x - x * other.z,
            x * other.y - y * other.x
        );
    }

    public Vector scale(double scalar) {
        return new Vector(x * scalar, y * scalar, z * scalar);
    }

    public Vector divide(double scalar) {
        return new Vector(x / scalar, y / scalar, z / scalar);
    }

    public double magnitude() {
        return Math.sqrt(x * x + y * y + z * z);
    }

    public Vector normalize() {
        double mag = magnitude();
        return mag != 0 ? divide(mag) : new Vector(0, 0, 0);
    }

    public double angle(Vector other) {
        Vector cross = cross(other);
        double magCross = cross.magnitude();
        double magProduct = magnitude() * other.magnitude();
        return magProduct != 0 ? Math.asin(magCross / magProduct) : 0.0;
    }
}

