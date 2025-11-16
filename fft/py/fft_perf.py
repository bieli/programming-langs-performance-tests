import math
import time

class Complex:
    def __init__(self, re, im):
        self.re = re
        self.im = im

    def __add__(self, other):
        return Complex(self.re + other.re, self.im + other.im)

    def __sub__(self, other):
        return Complex(self.re - other.re, self.im - other.im)

    def __mul__(self, other):
        return Complex(
            self.re * other.re - self.im * other.im,
            self.re * other.im + self.im * other.re
        )

    def __str__(self):
        return f"{self.re:.2f} + {self.im:.2f}i"

def fft(x):
    n = len(x)
    if n <= 1:
        return

    even = x[0::2]
    odd = x[1::2]

    fft(even)
    fft(odd)

    for k in range(n // 2):
        angle = -2 * math.pi * k / n
        twiddle = Complex(math.cos(angle), math.sin(angle)) * odd[k]
        x[k] = even[k] + twiddle
        x[k + n // 2] = even[k] - twiddle

def main():
    N = 1 << 20
    print(f"Generating {N}-point complex FFT input...")
    print("Technology: Python")

    data = [Complex(i % 256, 0.0) for i in range(N)]

    start = time.perf_counter()
    fft(data)
    end = time.perf_counter()

    print(f"FFT {N} points: {end - start:.6f} seconds")

if __name__ == "__main__":
    main()

