import time

N = 1_000_000_000

def generate_array(size):
    return list(range(size))

def linear_search(arr, target):
    for i, val in enumerate(arr):
        if val == target:
            return i
    return -1

def benchmark_search(arr, index, label):
    target = arr[index]
    start = time.perf_counter()
    result = linear_search(arr, target)
    end = time.perf_counter()
    elapsed = end - start
    print(f"{label}: {elapsed:.8f} seconds")

def main():
    print(f"Generating array of {N} integers... and searching for values located at")
    print("Technology: Python")

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

