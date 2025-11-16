package main

import (
    "fmt"
    "time"
)

const N = 1_000_000_000

func generateArray(size int) []int {
    arr := make([]int, size)
    for i := 0; i < size; i++ {
        arr[i] = i
    }
    return arr
}

func linearSearch(arr []int, target int) int {
    for i, val := range arr {
        if val == target {
            return i
        }
    }
    return -1
}

func benchmarkSearch(arr []int, index int, label string) {
    target := arr[index]
    start := time.Now()
    _ = linearSearch(arr, target)
    elapsed := time.Since(start).Seconds()
    fmt.Printf("%s: %f seconds\n", label, elapsed)
}

func main() {
    fmt.Printf("Generating array of %d integers... and searching for values located at\n", N)
    fmt.Println("Technology: Go")

    data := generateArray(N)

    benchmarkSearch(data, N/100, "0%")
    benchmarkSearch(data, N/20, "5%")
    benchmarkSearch(data, N*15/100, "15%")
    benchmarkSearch(data, N/4, "25%")
    benchmarkSearch(data, N/2, "50%")
    benchmarkSearch(data, N*3/4, "75%")
    benchmarkSearch(data, N-1, "100%")
}

