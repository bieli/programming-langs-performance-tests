# distutils: language = c++
import numpy as np
cimport numpy as np
cimport cython

@cython.boundscheck(False)
@cython.wraparound(False)
cdef class Vector:
    cdef double[::1] v

    def __init__(self, double x, double y, double z):
        self.v = np.array([x, y, z], dtype=np.float64)

    cpdef Vector add(self, Vector other):
        return Vector(self.v[0] + other.v[0], self.v[1] + other.v[1], self.v[2] + other.v[2])

    cpdef Vector subtract(self, Vector other):
        return Vector(self.v[0] - other.v[0], self.v[1] - other.v[1], self.v[2] - other.v[2])

    cpdef Vector cross(self, Vector other):
        cdef np.ndarray[np.float64_t, ndim=1] c = np.cross(self.v, other.v)
        return Vector(c[0], c[1], c[2])

    cpdef Vector scale(self, double scalar):
        return Vector(self.v[0] * scalar, self.v[1] * scalar, self.v[2] * scalar)

    cpdef Vector divide(self, double scalar):
        return Vector(self.v[0] / scalar, self.v[1] / scalar, self.v[2] / scalar)

    cpdef double magnitude(self):
        return np.linalg.norm(self.v)

    cpdef Vector normalize(self):
        cdef double mag = self.magnitude()
        if mag != 0:
            return self.divide(mag)
        else:
            return Vector(0, 0, 0)

    cpdef double angle(self, Vector other):
        cdef double cross_mag = np.linalg.norm(np.cross(self.v, other.v))
        cdef double prod_mag = self.magnitude() * other.magnitude()
        if prod_mag != 0:
            return np.arcsin(cross_mag / prod_mag)
        else:
            return 0.0

