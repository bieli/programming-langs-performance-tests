#include <stdio.h>
#include <time.h>
#include "vector2d.h"

#define ITERATIONS 100000000

int main() {
    Vector2D v1 = {1.0, 2.0};
    Vector2D v2 = {3.0, 4.0};

    clock_t start, end;
    double elapsed;

    #define BENCHMARK(label, expr) \
        start = clock(); \
        for (int i = 0; i < ITERATIONS; i++) { expr; } \
        end = clock(); \
        elapsed = (double)(end - start) / CLOCKS_PER_SEC; \
        printf("%s: %.8f seconds\n", label, elapsed);

    printf("Technology: ANSI C11\n");
    BENCHMARK("Addition", add(v1, v2));
    BENCHMARK("Subtraction", subtract(v1, v2));
    BENCHMARK("Scaling", scale(v1, 2.5));
    BENCHMARK("Normalization", normalize(v1));
    BENCHMARK("Angle", angle(v1, v2));

    return 0;
}

