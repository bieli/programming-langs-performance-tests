#ifndef VECTOR2D_H
#define VECTOR2D_H

#include <cmath>
#include <ostream>

class Vector2D {
public:
    double x, y;

    Vector2D(double x = 0.0, double y = 0.0) : x(x), y(y) {}

    Vector2D operator+(const Vector2D& other) const {
        return Vector2D(x + other.x, y + other.y);
    }

    Vector2D operator-(const Vector2D& other) const {
        return Vector2D(x - other.x, y - other.y);
    }

    Vector2D operator*(double scalar) const {
        return Vector2D(x * scalar, y * scalar);
    }

    double magnitude() const {
        return std::sqrt(x * x + y * y);
    }

    Vector2D normalized() const {
        double mag = magnitude();
        return mag == 0.0 ? Vector2D(0.0, 0.0) : Vector2D(x / mag, y / mag);
    }

    double angle(const Vector2D& other) const {
        double dot = x * other.x + y * other.y;
        double magA = magnitude();
        double magB = other.magnitude();
        double cosTheta = dot / (magA * magB + 1e-9);
        return std::acos(cosTheta) * 180.0 / M_PI;
    }

    friend std::ostream& operator<<(std::ostream& os, const Vector2D& v) {
        return os << "(" << v.x << ", " << v.y << ")";
    }
};

#endif // VECTOR2D_H

