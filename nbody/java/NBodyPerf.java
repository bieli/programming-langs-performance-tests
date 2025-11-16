import java.util.Random;

public class NBodyPerf {

    static final int N = 10000;          // Number of bodies
    static final int STEPS = 10;         // Number of simulation steps
    static final double DT = 0.01;       // Time step
    static final double G = 6.67430e-11; // Gravitational constant

    static class Body {
        double x, y, z;
        double vx, vy, vz;
        double mass;
    }

    static Body[] initBodies(int n) {
        Random rand = new Random();
        Body[] bodies = new Body[n];
        for (int i = 0; i < n; i++) {
            Body b = new Body();
            b.x = rand.nextDouble() * 1e5;
            b.y = rand.nextDouble() * 1e5;
            b.z = rand.nextDouble() * 1e5;
            b.vx = b.vy = b.vz = 0.0;
            b.mass = rand.nextDouble() * 1e22 + 1e20;
            bodies[i] = b;
        }
        return bodies;
    }

    static void simulate(Body[] bodies, int steps, double dt) {
        for (int s = 0; s < steps; s++) {
            double[] fx = new double[N];
            double[] fy = new double[N];
            double[] fz = new double[N];

            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    if (i == j) continue;
                    double dx = bodies[j].x - bodies[i].x;
                    double dy = bodies[j].y - bodies[i].y;
                    double dz = bodies[j].z - bodies[i].z;
                    double dist = Math.sqrt(dx * dx + dy * dy + dz * dz) + 1e-9;
                    double force = G * bodies[i].mass * bodies[j].mass / (dist * dist);
                    fx[i] += force * dx / dist;
                    fy[i] += force * dy / dist;
                    fz[i] += force * dz / dist;
                }
            }

            for (int i = 0; i < N; i++) {
                bodies[i].vx += fx[i] / bodies[i].mass * dt;
                bodies[i].vy += fy[i] / bodies[i].mass * dt;
                bodies[i].vz += fz[i] / bodies[i].mass * dt;
            }

            for (int i = 0; i < N; i++) {
                bodies[i].x += bodies[i].vx * dt;
                bodies[i].y += bodies[i].vy * dt;
                bodies[i].z += bodies[i].vz * dt;
            }
        }
    }

    public static void main(String[] args) {
        System.out.printf("Running N-body simulation with %d bodies for %d steps...\n", N, STEPS);
        System.out.println("Technology: Java");

        Body[] bodies = initBodies(N);

        long start = System.nanoTime();
        simulate(bodies, STEPS, DT);
        long end = System.nanoTime();

        double elapsed = (end - start) / 1e9;
        System.out.printf("%d-bodies for %d steps: %.6f seconds\n", N, STEPS, elapsed);
    }
}

