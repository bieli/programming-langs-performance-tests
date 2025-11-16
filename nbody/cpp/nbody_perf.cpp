#include <iostream>
#include <vector>
#include <cmath>
#include <cstdlib>
#include <chrono>
#include <iomanip>

const int N = 10000;             // Number of bodies
const int STEPS = 10;            // Number of simulation steps
const double DT = 0.01;          // Time step
const double G = 6.67430e-11;    // Gravitational constant

struct Body {
    double x, y, z;
    double vx, vy, vz;
    double mass;
};

std::vector<Body> initBodies(int n) {
    std::vector<Body> bodies(n);
    for (int i = 0; i < n; ++i) {
        bodies[i].x = (double)rand() / RAND_MAX * 1e5;
        bodies[i].y = (double)rand() / RAND_MAX * 1e5;
        bodies[i].z = (double)rand() / RAND_MAX * 1e5;
        bodies[i].vx = bodies[i].vy = bodies[i].vz = 0.0;
        bodies[i].mass = (double)rand() / RAND_MAX * 1e22 + 1e20;
    }
    return bodies;
}

void simulate(std::vector<Body>& bodies, int steps, double dt) {
    for (int s = 0; s < steps; ++s) {
        for (int i = 0; i < N; ++i) {
            double fx = 0, fy = 0, fz = 0;
            for (int j = 0; j < N; ++j) {
                if (i == j) continue;
                double dx = bodies[j].x - bodies[i].x;
                double dy = bodies[j].y - bodies[i].y;
                double dz = bodies[j].z - bodies[i].z;
                double dist = std::sqrt(dx*dx + dy*dy + dz*dz) + 1e-9;
                double force = G * bodies[i].mass * bodies[j].mass / (dist * dist);
                fx += force * dx / dist;
                fy += force * dy / dist;
                fz += force * dz / dist;
            }
            bodies[i].vx += fx / bodies[i].mass * dt;
            bodies[i].vy += fy / bodies[i].mass * dt;
            bodies[i].vz += fz / bodies[i].mass * dt;
        }

        for (int i = 0; i < N; ++i) {
            bodies[i].x += bodies[i].vx * dt;
            bodies[i].y += bodies[i].vy * dt;
            bodies[i].z += bodies[i].vz * dt;
        }
    }
}

int main() {
    std::cout << "Running N-body simulation with " << N << " bodies for " << STEPS << " steps...\n";
    std::cout << "Technology: CPP\n";

    std::vector<Body> bodies = initBodies(N);

    auto start = std::chrono::high_resolution_clock::now();
    simulate(bodies, STEPS, DT);
    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> elapsed = end - start;
    std::cout << N << "-bodies for " << STEPS << " steps: " << std::fixed << std::setprecision(6) << elapsed.count() << " seconds\n";

    return 0;
}

