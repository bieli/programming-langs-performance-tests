package main

import (
    "fmt"
    "math"
    "math/rand"
    "time"
)

const (
    N     = 10000         // Number of bodies
    STEPS = 10            // Number of simulation steps
    DT    = 0.01          // Time step
    G     = 6.67430e-11   // Gravitational constant
)

type Body struct {
    x, y, z   float64
    vx, vy, vz float64
    mass      float64
}

func initBodies(n int) []Body {
    bodies := make([]Body, n)
    for i := range bodies {
        bodies[i] = Body{
            x:    rand.Float64() * 1e5,
            y:    rand.Float64() * 1e5,
            z:    rand.Float64() * 1e5,
            vx:   0.0,
            vy:   0.0,
            vz:   0.0,
            mass: rand.Float64()*1e22 + 1e20,
        }
    }
    return bodies
}

func simulate(bodies []Body, steps int, dt float64) {
    for s := 0; s < steps; s++ {
        for i := range bodies {
            fx, fy, fz := 0.0, 0.0, 0.0
            for j := range bodies {
                if i == j {
                    continue
                }
                dx := bodies[j].x - bodies[i].x
                dy := bodies[j].y - bodies[i].y
                dz := bodies[j].z - bodies[i].z
                dist := math.Sqrt(dx*dx + dy*dy + dz*dz) + 1e-9
                force := G * bodies[i].mass * bodies[j].mass / (dist * dist)
                fx += force * dx / dist
                fy += force * dy / dist
                fz += force * dz / dist
            }
            bodies[i].vx += fx / bodies[i].mass * dt
            bodies[i].vy += fy / bodies[i].mass * dt
            bodies[i].vz += fz / bodies[i].mass * dt
        }
        for i := range bodies {
            bodies[i].x += bodies[i].vx * dt
            bodies[i].y += bodies[i].vy * dt
            bodies[i].z += bodies[i].vz * dt
        }
    }
}

func main() {
    fmt.Printf("Running N-body simulation with %d bodies for %d steps...\n", N, STEPS)
    fmt.Println("Technology: Go")

    rand.Seed(time.Now().UnixNano())
    bodies := initBodies(N)

    start := time.Now()
    simulate(bodies, STEPS, DT)
    elapsed := time.Since(start)

    fmt.Printf("%d-bodies for %d steps: %.6f seconds\n", N, STEPS, elapsed.Seconds())
}

