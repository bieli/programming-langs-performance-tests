use std::time::Instant;

const N: usize = 10000;          // Number of bodies
const STEPS: usize = 10;         // Number of simulation steps
const DT: f64 = 0.01;            // Time step
const G: f64 = 6.67430e-11;      // Gravitational constant

#[derive(Clone)]
struct Body {
    x: f64,
    y: f64,
    z: f64,
    vx: f64,
    vy: f64,
    vz: f64,
    mass: f64,
}

fn init_bodies(n: usize) -> Vec<Body> {
    let mut bodies = Vec::with_capacity(n);
    for _ in 0..n {
        bodies.push(Body {
            x: rand01() * 1e5,
            y: rand01() * 1e5,
            z: rand01() * 1e5,
            vx: 0.0,
            vy: 0.0,
            vz: 0.0,
            mass: rand01() * 1e22 + 1e20,
        });
    }
    bodies
}

fn rand01() -> f64 {
    rand::random::<f64>()
}

fn simulate(bodies: &mut [Body], steps: usize, dt: f64) {
    for _ in 0..steps {
        let mut forces = vec![(0.0, 0.0, 0.0); bodies.len()];

        for i in 0..bodies.len() {
            for j in 0..bodies.len() {
                if i == j { continue; }
                let dx = bodies[j].x - bodies[i].x;
                let dy = bodies[j].y - bodies[i].y;
                let dz = bodies[j].z - bodies[i].z;
                let dist = (dx*dx + dy*dy + dz*dz).sqrt() + 1e-9;
                let force = G * bodies[i].mass * bodies[j].mass / (dist * dist);
                let fx = force * dx / dist;
                let fy = force * dy / dist;
                let fz = force * dz / dist;
                forces[i].0 += fx;
                forces[i].1 += fy;
                forces[i].2 += fz;
            }
        }

        for (i, body) in bodies.iter_mut().enumerate() {
            body.vx += forces[i].0 / body.mass * dt;
            body.vy += forces[i].1 / body.mass * dt;
            body.vz += forces[i].2 / body.mass * dt;
        }

        for body in bodies.iter_mut() {
            body.x += body.vx * dt;
            body.y += body.vy * dt;
            body.z += body.vz * dt;
        }
    }
}

fn main() {
    println!("Running N-body simulation with {} bodies for {} steps...", N, STEPS);
    println!("Technology: Rust");

    let mut bodies = init_bodies(N);

    let start = Instant::now();
    simulate(&mut bodies, STEPS, DT);
    let duration = start.elapsed();

    println!("{}-bodies for {} steps: {:.6} seconds", N, STEPS, duration.as_secs_f64());
}

