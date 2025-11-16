# cython: boundscheck=False, wraparound=False, cdivision=True
from libc.math cimport sqrt
from libc.stdlib cimport malloc, free
from time import perf_counter
from random import random

cdef int N = 10000
cdef int STEPS = 10
cdef double DT = 0.01
cdef double G = 6.67430e-11

cdef struct Body:
    double x, y, z
    double vx, vy, vz
    double mass

def run_simulation():
    cdef Body* bodies = <Body*> malloc(N * sizeof(Body))
    if not bodies:
        raise MemoryError("Failed to allocate bodies")

    cdef int i, j, s
    cdef double dx, dy, dz, dist, force, fx, fy, fz

    for i in range(N):
        bodies[i].x = random() * 1e5
        bodies[i].y = random() * 1e5
        bodies[i].z = random() * 1e5
        bodies[i].vx = bodies[i].vy = bodies[i].vz = 0.0
        bodies[i].mass = random() * 1e22 + 1e20

    start = perf_counter()

    for s in range(STEPS):
        for i in range(N):
            fx = fy = fz = 0.0
            for j in range(N):
                if i == j:
                    continue
                dx = bodies[j].x - bodies[i].x
                dy = bodies[j].y - bodies[i].y
                dz = bodies[j].z - bodies[i].z
                dist = sqrt(dx*dx + dy*dy + dz*dz) + 1e-9
                force = G * bodies[i].mass * bodies[j].mass / (dist * dist)
                fx += force * dx / dist
                fy += force * dy / dist
                fz += force * dz / dist
            bodies[i].vx += fx / bodies[i].mass * DT
            bodies[i].vy += fy / bodies[i].mass * DT
            bodies[i].vz += fz / bodies[i].mass * DT

        for i in range(N):
            bodies[i].x += bodies[i].vx * DT
            bodies[i].y += bodies[i].vy * DT
            bodies[i].z += bodies[i].vz * DT

    end = perf_counter()
    print("Technology: Cython")
    print(f"10000-bodies for 10 steps: {end - start:.6f} seconds")

    free(bodies)


