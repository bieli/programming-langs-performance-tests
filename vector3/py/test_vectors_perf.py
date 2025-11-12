import time
import random
from vectors import Vector, angle

def random_vector():
    return Vector(random.random(), random.random(), random.random())

def benchmark(name, func, iterations=100_000_000):
    start = time.perf_counter()
    for _ in range(iterations):
        func()
    duration = time.perf_counter() - start
    print(f"{name}: {duration:.4f} seconds")

v1 = random_vector()
v2 = random_vector()

print("---")
print("Technology: Python")
benchmark("Addition", lambda: v1 + v2)
benchmark("Subtraction", lambda: v1 - v2)
benchmark("Cross Product", lambda: v1 * v2)
benchmark("Scalar Multiplication", lambda: 2.5 * v1)
benchmark("Normalization", lambda: v1.normalize())
benchmark("Angle", lambda: angle(v1, v2))
print("===")

