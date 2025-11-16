import numpy as np
import time

N = 1_000_000_000

def generate_array(size):
    return np.arange(size, dtype=np.int32)

def linear_search_numpy(arr, target):
    mask = arr == target
    return int(np.argmax(mask)) if np.any(mask) else -1

def benchmark_search(arr, index, label):
    target = arr[index]
    start = time.perf_counter()
    linear_search_numpy(arr, target)
    end = time.perf_counter()
    elapsed = end - start
    print(f"{label}: {elapsed:.6f} seconds")

def main():
    print(f"Generating array of {N} integers... and searching for values located at")
    print("Technology: Python + NumPy")

    data = generate_array(N)

    benchmark_search(data, N // 100, "0%")
    benchmark_search(data, N // 20, "5%")
    benchmark_search(data, N * 15 // 100, "15%")
    benchmark_search(data, N // 4, "25%")
    benchmark_search(data, N // 2, "50%")
    benchmark_search(data, N * 3 // 4, "75%")
    benchmark_search(data, N - 1, "100%")

if __name__ == "__main__":
    main()

