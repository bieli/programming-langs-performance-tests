#include "vector.hpp"

Vector::Vector(double x, double y, double z) : x(x), y(y), z(z) {}

Vector Vector::operator+(const Vector& other) const {
    return Vector(x + other.x, y + other.y, z + other.z);
}

Vector Vector::operator-(const Vector& other) const {
    return Vector(x - other.x, y - other.y, z - other.z);
}

Vector Vector::operator*(const Vector& other) const {
    return Vector(
        y * other.z - z * other.y,
        z * other.x - x * other.z,
        x * other.y - y * other.x
    );
}

Vector Vector::operator*(double scalar) const {
    return Vector(x * scalar, y * scalar, z * scalar);
}

Vector Vector::operator/(double scalar) const {
    return Vector(x / scalar, y / scalar, z / scalar);
}

double Vector::magnitude() const {
    return std::sqrt(x * x + y * y + z * z);
}

Vector Vector::normalize() const {
    double mag = magnitude();
    return mag != 0 ? *this / mag : Vector(0, 0, 0);
}

double Vector::angle(const Vector& other) const {
    Vector cross = *this * other;
    double mag_cross = cross.magnitude();
    double mag_product = magnitude() * other.magnitude();
    return mag_product != 0 ? std::asin(mag_cross / mag_product) : 0.0;
}

