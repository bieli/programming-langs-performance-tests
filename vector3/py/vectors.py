from dataclasses import dataclass
from math import sqrt, asin
from typing import List

@dataclass
class Vector:
    x: float
    y: float
    z: float

    def add(self, other: 'Vector') -> None:
        self.x += other.x
        self.y += other.y
        self.z += other.z

    def __add__(self, other: 'Vector') -> 'Vector':
        return Vector(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other: 'Vector') -> 'Vector':
        return Vector(self.x - other.x, self.y - other.y, self.z - other.z)

    def __mul__(self, other) -> 'Vector':
        if isinstance(other, Vector):
            # Cross product
            return Vector(
                self.y * other.z - self.z * other.y,
                self.z * other.x - self.x * other.z,
                self.x * other.y - self.y * other.x
            )
        elif isinstance(other, (int, float)):
            # Scalar multiplication
            return Vector(self.x * other, self.y * other, self.z * other)
        else:
            raise TypeError("Unsupported operand type for *")

    def __rmul__(self, other: float) -> 'Vector':
        return self.__mul__(other)

    def __truediv__(self, scalar: float) -> 'Vector':
        return Vector(self.x / scalar, self.y / scalar, self.z / scalar)

    def magnitude(self) -> float:
        return sqrt(self.x**2 + self.y**2 + self.z**2)

    def magnitude_squared(self) -> float:
        return self.x**2 + self.y**2 + self.z**2

    def normalize(self) -> 'Vector':
        mag = self.magnitude()
        return self / mag if mag != 0 else Vector(0, 0, 0)

def vector(x: float, y: float, z: float) -> Vector:
    return Vector(x, y, z)

def vector_xy(x: float, y: float) -> Vector:
    return Vector(x, y, 0)

def angle(a: Vector, b: Vector) -> float:
    cross_mag = (a * b).magnitude()
    prod_mag = a.magnitude() * b.magnitude()
    return asin(cross_mag / prod_mag) if prod_mag != 0 else 0.0

VectorArray = List[Vector]

