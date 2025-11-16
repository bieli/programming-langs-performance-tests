import std.stdio;
import std.math;
import std.datetime;
import std.random;

enum N = 10000;          // Number of bodies
enum STEPS = 10;         // Number of simulation steps
enum DT = 0.01;          // Time step
enum G = 6.67430e-11;    // Gravitational constant

struct Body {
    double x, y, z;
    double vx, vy, vz;
    double mass;
}

void initBodies(ref Body[] bodies) {
    auto rnd = Random(unpredictableSeed);
    foreach (i; 0 .. bodies.length) {
        bodies[i].x = uniform(0.0, 1e5, rnd);
        bodies[i].y = uniform(0.0, 1e5, rnd);
        bodies[i].z = uniform(0.0, 1e5, rnd);
        bodies[i].vx = 0.0;
        bodies[i].vy = 0.0;
        bodies[i].vz = 0.0;
        bodies[i].mass = uniform(1e20, 1e22, rnd);
    }
}

void simulate(ref Body[] bodies, int steps, double dt) {
    foreach (s; 0 .. steps) {
        foreach (i; 0 .. bodies.length) {
            double fx = 0, fy = 0, fz = 0;
            foreach (j; 0 .. bodies.length) {
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

        foreach (ref b; bodies) {
            b.x += b.vx * dt;
            b.y += b.vy * dt;
            b.z += b.vz * dt;
        }
    }
}

void main() {
    writeln("Running N-body simulation with ", N, " bodies for ", STEPS, " steps...");
    writeln("Technology: D");

    Body[] bodies = new Body[N];
    initBodies(bodies);

    auto start = Clock.currTime();
    simulate(bodies, STEPS, DT);
    auto end = Clock.currTime();

    auto elapsed = end - start;
    writeln(N, "-bodies for ", STEPS, " steps: ", elapsed.total!"seconds", " seconds");
}

