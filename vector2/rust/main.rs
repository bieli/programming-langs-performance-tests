use std::time::Instant;
use std::f64::consts::PI;

const ITERATIONS: usize = 100_000_000;

#[derive(Copy, Clone)]
struct Vector2D {
    x: f64,
    y: f64,
}

impl Vector2D {
    fn add(a: Vector2D, b: Vector2D) -> Vector2D {
        Vector2D { x: a.x + b.x, y: a.y + b.y }
    }

    fn subtract(a: Vector2D, b: Vector2D) -> Vector2D {
        Vector2D { x: a.x - b.x, y: a.y - b.y }
    }

    fn scale(a: Vector2D, s: f64) -> Vector2D {
        Vector2D { x: a.x * s, y: a.y * s }
    }

    fn magnitude(a: Vector2D) -> f64 {
        (a.x * a.x + a.y * a.y).sqrt()
    }

    fn normalize(a: Vector2D) -> Vector2D {
        let mag = Vector2D::magnitude(a);
        if mag == 0.0 {
            Vector2D { x: 0.0, y: 0.0 }
        } else {
            Vector2D { x: a.x / mag, y: a.y / mag }
        }
    }

    fn angle(a: Vector2D, b: Vector2D) -> f64 {
        let dot = a.x * b.x + a.y * b.y;
        let mag_a = Vector2D::magnitude(a);
        let mag_b = Vector2D::magnitude(b);
        let cos_theta = dot / (mag_a * mag_b + 1e-9);
        cos_theta.acos() * 180.0 / PI
    }
}

macro_rules! benchmark {
    ($label:expr, $expr:expr) => {{
        let start = Instant::now();
        for _ in 0..ITERATIONS {
            let _ = $expr;
        }
        let elapsed = start.elapsed().as_secs_f64();
        println!("{}: {:.8} seconds", $label, elapsed);
    }};
}

fn main() {
    let v1 = Vector2D { x: 1.0, y: 2.0 };
    let v2 = Vector2D { x: 3.0, y: 4.0 };

    println!("Technology: Rust");

    benchmark!("Addition", Vector2D::add(v1, v2));
    benchmark!("Subtraction", Vector2D::subtract(v1, v2));
    benchmark!("Scaling", Vector2D::scale(v1, 2.5));
    benchmark!("Normalization", Vector2D::normalize(v1));
    benchmark!("Angle", Vector2D::angle(v1, v2));
}

