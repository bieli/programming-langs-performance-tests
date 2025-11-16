package main

import (
    "fmt"
    "math"
    "time"
)

const N = 1 << 20

type Complex struct {
    re, im float64
}

func add(a, b Complex) Complex {
    return Complex{a.re + b.re, a.im + b.im}
}

func sub(a, b Complex) Complex {
    return Complex{a.re - b.re, a.im - b.im}
}

func mul(a, b Complex) Complex {
    return Complex{
        a.re*b.re - a.im*b.im,
        a.re*b.im + a.im*b.re,
    }
}

func fft(x []Complex) {
    n := len(x)
    if n <= 1 {
        return
    }

    even := make([]Complex, n/2)
    odd := make([]Complex, n/2)
    for i := 0; i < n/2; i++ {
        even[i] = x[2*i]
        odd[i] = x[2*i+1]
    }

    fft(even)
    fft(odd)

    for k := 0; k < n/2; k++ {
        angle := -2 * math.Pi * float64(k) / float64(n)
        twiddle := Complex{math.Cos(angle), math.Sin(angle)}
        t := mul(twiddle, odd[k])
        x[k] = add(even[k], t)
        x[k+n/2] = sub(even[k], t)
    }
}

func main() {
    fmt.Printf("Generating %d-point complex FFT input...\n", N)
    fmt.Println("Technology: Go")

    data := make([]Complex, N)
    for i := 0; i < N; i++ {
        data[i] = Complex{float64(i % 256), 0.0}
    }

    start := time.Now()
    fft(data)
    elapsed := time.Since(start).Seconds()

    fmt.Printf("FFT %d points: %.6f seconds\n", N, elapsed)
}

