#ifndef VECTOR_H
#define VECTOR_H

#include <math.h>

typedef struct {
    double x;
    double y;
    double z;
} Vector;

Vector vector(double x, double y, double z);
Vector vector_add(Vector a, Vector b);
Vector vector_sub(Vector a, Vector b);
Vector vector_cross(Vector a, Vector b);
Vector vector_scale(Vector a, double s);
Vector vector_div(Vector a, double s);
double vector_mag(Vector a);
Vector vector_norm(Vector a);
double vector_angle(Vector a, Vector b);

#endif

