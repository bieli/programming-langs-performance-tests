mod vector;
use vector::Vector;
use std::time::Instant;

const ITERATIONS: usize = 100_000_000;

fn benchmark<F: FnMut()>(label: &str, mut f: F) {
    let start = Instant::now();
    f();
    let duration = start.elapsed();
    println!("{}: {:>.10} seconds", label, duration.as_secs_f64());
}

fn main() {
    let v1 = Vector::new(1.0, 2.0, 3.0);
    let v2 = Vector::new(4.0, 5.0, 6.0);

    println!("Technology: Rust");
    benchmark("Addition", || {
        let mut _result;
        for _ in 0..ITERATIONS {
            _result = v1.add(v2);
        }
    });

    benchmark("Subtraction", || {
        let mut _result;
        for _ in 0..ITERATIONS {
            _result = v1.sub(v2);
        }
    });

    benchmark("Cross Product", || {
        let mut _result;
        for _ in 0..ITERATIONS {
            _result = v1.cross(v2);
        }
    });

    benchmark("Scalar Multiplication", || {
        let mut _result;
        for _ in 0..ITERATIONS {
            _result = v1.scale(2.5);
        }
    });

    benchmark("Normalization", || {
        let mut _result;
        for _ in 0..ITERATIONS {
            _result = v1.normalize();
        }
    });

    benchmark("Angle", || {
        for _ in 0..ITERATIONS {
            let _ = v1.angle(v2);
        }
    });
}

