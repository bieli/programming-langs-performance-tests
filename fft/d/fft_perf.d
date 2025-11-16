import std.stdio;
import std.math;
import std.format;
import std.datetime.stopwatch;

struct Complex {
    double re, im;

    static Complex add(Complex a, Complex b) {
        return Complex(a.re + b.re, a.im + b.im);
    }

    static Complex sub(Complex a, Complex b) {
        return Complex(a.re - b.re, a.im - b.im);
    }

    static Complex mul(Complex a, Complex b) {
        return Complex(
            a.re * b.re - a.im * b.im,
            a.re * b.im + a.im * b.re
        );
    }

    string toString() const {
        return format("%.2f + %.2fi", re, im);
    }
}

void fft(ref Complex[] x) {
    size_t n = x.length;
    if (n <= 1) return;

    Complex[] even = new Complex[n / 2];
    Complex[] odd  = new Complex[n / 2];

    foreach (i; 0 .. n / 2) {
        even[i] = x[2 * i];
        odd[i]  = x[2 * i + 1];
    }

    fft(even);
    fft(odd);

    foreach (k; 0 .. n / 2) {
        double angle = -2 * PI * k / n;
        Complex twiddle = Complex(cos(angle), sin(angle));
        Complex t = Complex.mul(twiddle, odd[k]);
        x[k] = Complex.add(even[k], t);
        x[k + n / 2] = Complex.sub(even[k], t);
    }
}

void main() {
    enum N = 1 << 20;
    writeln("Generating ", N, "-point complex FFT input...");
    writeln("Technology: D");

    Complex[] data = new Complex[N];
    foreach (i; 0 .. N) {
        data[i] = Complex(i % 256, 0.0);
    }

    auto sw = StopWatch(AutoStart.yes);
    fft(data);
    sw.stop();
    auto elapsedNanos = sw.peek.total!"nsecs";
    double elapsedSecs = cast(double)elapsedNanos / 1e9;
    writeln(format("FFT %d points: %.8f seconds", N, elapsedSecs));
}

