#ifndef VECTOR2D_H
#define VECTOR2D_H

#include <math.h>

typedef struct {
    double x;
    double y;
} Vector2D;

Vector2D add(Vector2D a, Vector2D b);
Vector2D subtract(Vector2D a, Vector2D b);
Vector2D scale(Vector2D v, double s);
Vector2D divide(Vector2D v, double s);

double magnitude(Vector2D v);
Vector2D normalize(Vector2D v);

double angle(Vector2D a, Vector2D b);

#endif

