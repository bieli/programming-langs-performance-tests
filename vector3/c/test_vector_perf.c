#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "vector.h"

#define ITERATIONS 100000000

double rand_double() {
    return (double)rand() / RAND_MAX;
}

void benchmark(const char *name, void (*func)(void)) {
    clock_t start = clock();
    func();
    clock_t end = clock();
    double duration = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%s: %.4f seconds\n", name, duration);
}

Vector v1, v2, v3;

void test_add() {
    for (int i = 0; i < ITERATIONS; i++)
        v3 = vector_add(v1, v2);
}

void test_sub() {
    for (int i = 0; i < ITERATIONS; i++)
        v3 = vector_sub(v1, v2);
}

void test_cross() {
    for (int i = 0; i < ITERATIONS; i++)
        v3 = vector_cross(v1, v2);
}

void test_scale() {
    for (int i = 0; i < ITERATIONS; i++)
        v3 = vector_scale(v1, 2.5);
}

void test_norm() {
    for (int i = 0; i < ITERATIONS; i++)
        v3 = vector_norm(v1);
}

void test_angle() {
    for (int i = 0; i < ITERATIONS; i++)
        vector_angle(v1, v2);
}

int main() {
    srand((unsigned)time(NULL));
    v1 = vector(rand_double(), rand_double(), rand_double());
    v2 = vector(rand_double(), rand_double(), rand_double());

    benchmark("Addition", test_add);
    benchmark("Subtraction", test_sub);
    benchmark("Cross Product", test_cross);
    benchmark("Scalar Multiplication", test_scale);
    benchmark("Normalization", test_norm);
    benchmark("Angle", test_angle);

    return 0;
}

