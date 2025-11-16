from vector import Vector
import time

ITERATIONS = 100_000_000
v1 = Vector(1.0, 2.0, 3.0)
v2 = Vector(4.0, 5.0, 6.0)

def benchmark(label, func):
    start = time.perf_counter()
    func()
    end = time.perf_counter()
    print(f"{label:<22} {end - start:.6f} seconds")

print("Technology: Cython")
benchmark("Addition", lambda: [v1.add(v2) for _ in range(ITERATIONS)])
benchmark("Subtraction", lambda: [v1.subtract(v2) for _ in range(ITERATIONS)])
benchmark("Cross Product", lambda: [v1.cross(v2) for _ in range(ITERATIONS)])
benchmark("Scalar Multiplication", lambda: [v1.scale(2.5) for _ in range(ITERATIONS)])
benchmark("Normalization", lambda: [v1.normalize() for _ in range(ITERATIONS)])
benchmark("Angle", lambda: [v1.angle(v2) for _ in range(ITERATIONS)])

