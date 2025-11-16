#define _POSIX_C_SOURCE 199309L
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define N 10000        // Number of bodies
#define STEPS 10       // Number of simulation steps
#define DT 0.01        // Time step
#define G 6.67430e-11  // Gravitational constant

typedef struct {
    double x, y, z;
    double vx, vy, vz;
    double mass;
} Body;

void init_bodies(Body *bodies, int n) {
    for (int i = 0; i < n; i++) {
        bodies[i].x = rand() / (double)RAND_MAX * 1e5;
        bodies[i].y = rand() / (double)RAND_MAX * 1e5;
        bodies[i].z = rand() / (double)RAND_MAX * 1e5;
        bodies[i].vx = bodies[i].vy = bodies[i].vz = 0.0;
        bodies[i].mass = rand() / (double)RAND_MAX * 1e22 + 1e20;
    }
}

void simulate(Body *bodies, int n, int steps, double dt) {
    for (int s = 0; s < steps; s++) {
        for (int i = 0; i < n; i++) {
            double fx = 0, fy = 0, fz = 0;
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                double dx = bodies[j].x - bodies[i].x;
                double dy = bodies[j].y - bodies[i].y;
                double dz = bodies[j].z - bodies[i].z;
                double dist = sqrt(dx*dx + dy*dy + dz*dz) + 1e-9;
                double force = G * bodies[i].mass * bodies[j].mass / (dist * dist);
                fx += force * dx / dist;
                fy += force * dy / dist;
                fz += force * dz / dist;
            }
            bodies[i].vx += fx / bodies[i].mass * dt;
            bodies[i].vy += fy / bodies[i].mass * dt;
            bodies[i].vz += fz / bodies[i].mass * dt;
        }

        for (int i = 0; i < n; i++) {
            bodies[i].x += bodies[i].vx * dt;
            bodies[i].y += bodies[i].vy * dt;
            bodies[i].z += bodies[i].vz * dt;
        }
    }
}

double get_time_sec() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main() {
    printf("Running N-body simulation with %d bodies for %d steps...\n", N, STEPS);
    printf("Technology: ANSI C99\n");

    Body *bodies = malloc(N * sizeof(Body));
    if (!bodies) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    init_bodies(bodies, N);

    double start = get_time_sec();
    simulate(bodies, N, STEPS, DT);
    double end = get_time_sec();

    printf("%d-bodies for %d steps: %.6f seconds\n", N, STEPS, end - start);

    free(bodies);
    return 0;
}

