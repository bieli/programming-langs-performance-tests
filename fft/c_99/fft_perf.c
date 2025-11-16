#define _POSIX_C_SOURCE 199309L
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define N (1 << 20)
#define PI 3.14159265358979323846

typedef struct {
    double real;
    double imag;
} Complex;

void fft(Complex *x, int n) {
    if (n <= 1) return;

    Complex *even = malloc(n / 2 * sizeof(Complex));
    Complex *odd  = malloc(n / 2 * sizeof(Complex));
    for (int i = 0; i < n / 2; i++) {
        even[i] = x[i * 2];
        odd[i]  = x[i * 2 + 1];
    }

    fft(even, n / 2);
    fft(odd, n / 2);

    for (int k = 0; k < n / 2; k++) {
        double angle = -2 * PI * k / n;
        Complex t = {
            cos(angle) * odd[k].real - sin(angle) * odd[k].imag,
            sin(angle) * odd[k].real + cos(angle) * odd[k].imag
        };
        x[k].real       = even[k].real + t.real;
        x[k].imag       = even[k].imag + t.imag;
        x[k + n/2].real = even[k].real - t.real;
        x[k + n/2].imag = even[k].imag - t.imag;
    }

    free(even);
    free(odd);
}

double get_time_sec() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main() {
    printf("Generating %d-point complex FFT input...\n", N);
    printf("Technology: ANSI C99\n");

    Complex *data = malloc(N * sizeof(Complex));
    if (!data) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    for (int i = 0; i < N; i++) {
        data[i].real = i % 256;
        data[i].imag = 0.0;
    }

    double start = get_time_sec();
    fft(data, N);
    double end = get_time_sec();

    printf("FFT %d points: %.8f seconds\n", N, end - start);

    free(data);
    return 0;
}

