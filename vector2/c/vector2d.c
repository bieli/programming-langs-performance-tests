#include "vector2d.h"

Vector2D add(Vector2D a, Vector2D b) {
    return (Vector2D){ a.x + b.x, a.y + b.y };
}

Vector2D subtract(Vector2D a, Vector2D b) {
    return (Vector2D){ a.x - b.x, a.y - b.y };
}

Vector2D scale(Vector2D v, double s) {
    return (Vector2D){ v.x * s, v.y * s };
}

Vector2D divide(Vector2D v, double s) {
    return (Vector2D){ v.x / s, v.y / s };
}

double magnitude(Vector2D v) {
    return sqrt(v.x * v.x + v.y * v.y);
}

Vector2D normalize(Vector2D v) {
    double mag = magnitude(v);
    return mag != 0 ? divide(v, mag) : (Vector2D){ 0, 0 };
}

double angle(Vector2D a, Vector2D b) {
    double cross = a.x * b.y - a.y * b.x;
    double dot = a.x * b.x + a.y * b.y;
    return atan2(cross, dot);
}

