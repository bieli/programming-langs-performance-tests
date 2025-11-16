use std::f64::consts::PI;
use std::time::Instant;

#[derive(Clone, Copy, Debug)]
struct Complex {
    re: f64,
    im: f64,
}

impl Complex {
    fn new(re: f64, im: f64) -> Self {
        Complex { re, im }
    }

    fn add(self, other: Complex) -> Complex {
        Complex::new(self.re + other.re, self.im + other.im)
    }

    fn sub(self, other: Complex) -> Complex {
        Complex::new(self.re - other.re, self.im - other.im)
    }

    fn mul(self, other: Complex) -> Complex {
        Complex::new(
            self.re * other.re - self.im * other.im,
            self.re * other.im + self.im * other.re,
        )
    }
}

fn fft(x: &mut [Complex]) {
    let n = x.len();
    if n <= 1 {
        return;
    }

    let mut even = x.iter().step_by(2).cloned().collect::<Vec<_>>();
    let mut odd = x.iter().skip(1).step_by(2).cloned().collect::<Vec<_>>();

    fft(&mut even);
    fft(&mut odd);

    for k in 0..n / 2 {
        let angle = -2.0 * PI * k as f64 / n as f64;
        let twiddle = Complex::new(angle.cos(), angle.sin()).mul(odd[k]);
        x[k] = even[k].add(twiddle);
        x[k + n / 2] = even[k].sub(twiddle);
    }
}

fn main() {
    const N: usize = 1 << 20;
    println!("Generating {}-point complex FFT input...", N);
    println!("Technology: Rust");

    let mut data = Vec::with_capacity(N);
    for i in 0..N {
        data.push(Complex::new((i % 256) as f64, 0.0));
    }

    let start = Instant::now();
    fft(&mut data);
    let duration = start.elapsed();

    println!("FFT {} points: {:.6} seconds", N, duration.as_secs_f64());
}

