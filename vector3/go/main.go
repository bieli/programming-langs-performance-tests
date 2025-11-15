package main

import (
    "fmt"
    "time"
    "vector_perf/vector"
)

const iterations = 100000000

func benchmark(label string, fn func()) {
    start := time.Now()
    fn()
    duration := time.Since(start).Seconds()
    fmt.Printf("%s: %.6f seconds\n", label, duration)
}

func main() {
    v1 := vector.New(1.0, 2.0, 3.0)
    v2 := vector.New(4.0, 5.0, 6.0)

    fmt.Printf("Technology: Go\n")
    benchmark("Addition", func() {
        for i := 0; i < iterations; i++ {
            _ = v1.Add(v2)
        }
    })

    benchmark("Subtraction", func() {
        for i := 0; i < iterations; i++ {
            _ = v1.Sub(v2)
        }
    })

    benchmark("Cross Product", func() {
        for i := 0; i < iterations; i++ {
            _ = v1.Cross(v2)
        }
    })

    benchmark("Scalar Multiplication", func() {
        for i := 0; i < iterations; i++ {
            _ = v1.Scale(2.5)
        }
    })

    benchmark("Normalization", func() {
        for i := 0; i < iterations; i++ {
            _ = v1.Normalize()
        }
    })

    benchmark("Angle", func() {
        for i := 0; i < iterations; i++ {
            _ = v1.Angle(v2)
        }
    })
}

