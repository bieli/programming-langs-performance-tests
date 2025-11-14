#ifndef VECTOR_HPP
#define VECTOR_HPP

#include <cmath>

class Vector {
public:
    double x, y, z;

    Vector(double x = 0, double y = 0, double z = 0);

    Vector operator+(const Vector& other) const;
    Vector operator-(const Vector& other) const;
    Vector operator*(const Vector& other) const;
    Vector operator*(double scalar) const;
    Vector operator/(double scalar) const;

    double magnitude() const;
    Vector normalize() const;
    double angle(const Vector& other) const;
};

#endif

