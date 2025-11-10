#include "vector.h"

Vector vector(double x, double y, double z) {
    Vector v = {x, y, z};
    return v;
}

Vector vector_add(Vector a, Vector b) {
    return vector(a.x + b.x, a.y + b.y, a.z + b.z);
}

Vector vector_sub(Vector a, Vector b) {
    return vector(a.x - b.x, a.y - b.y, a.z - b.z);
}

Vector vector_cross(Vector a, Vector b) {
    return vector(
        a.y * b.z - a.z * b.y,
        a.z * b.x - a.x * b.z,
        a.x * b.y - a.y * b.x
    );
}

Vector vector_scale(Vector a, double s) {
    return vector(a.x * s, a.y * s, a.z * s);
}

Vector vector_div(Vector a, double s) {
    return vector(a.x / s, a.y / s, a.z / s);
}

double vector_mag(Vector a) {
    return sqrt(a.x * a.x + a.y * a.y + a.z * a.z);
}

Vector vector_norm(Vector a) {
    double m = vector_mag(a);
    return m != 0 ? vector_div(a, m) : vector(0, 0, 0);
}

double vector_angle(Vector a, Vector b) {
    Vector cross = vector_cross(a, b);
    double mag_cross = vector_mag(cross);
    double mag_prod = vector_mag(a) * vector_mag(b);
    return mag_prod != 0 ? asin(mag_cross / mag_prod) : 0.0;
}

