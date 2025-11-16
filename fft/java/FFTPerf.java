public class FFTPerf {

    static class Complex {
        double re, im;

        Complex(double re, double im) {
            this.re = re;
            this.im = im;
        }

        Complex add(Complex other) {
            return new Complex(this.re + other.re, this.im + other.im);
        }

        Complex sub(Complex other) {
            return new Complex(this.re - other.re, this.im - other.im);
        }

        Complex mul(Complex other) {
            return new Complex(
                this.re * other.re - this.im * other.im,
                this.re * other.im + this.im * other.re
            );
        }
    }

    static void fft(Complex[] x) {
        int n = x.length;
        if (n <= 1) return;

        Complex[] even = new Complex[n / 2];
        Complex[] odd = new Complex[n / 2];
        for (int i = 0; i < n / 2; i++) {
            even[i] = x[2 * i];
            odd[i] = x[2 * i + 1];
        }

        fft(even);
        fft(odd);

        for (int k = 0; k < n / 2; k++) {
            double angle = -2 * Math.PI * k / n;
            Complex twiddle = new Complex(Math.cos(angle), Math.sin(angle)).mul(odd[k]);
            x[k] = even[k].add(twiddle);
            x[k + n / 2] = even[k].sub(twiddle);
        }
    }

    public static void main(String[] args) {
        final int N = 1 << 20;
        System.out.println("Generating " + N + "-point complex FFT input...");
        System.out.println("Technology: Java");

        Complex[] data = new Complex[N];
        for (int i = 0; i < N; i++) {
            data[i] = new Complex(i % 256, 0.0);
        }

        long start = System.nanoTime();
        fft(data);
        long end = System.nanoTime();

        double elapsed = (end - start) / 1e9;
        System.out.printf("FFT %d points: %.6f seconds%n", N, elapsed);
    }
}

