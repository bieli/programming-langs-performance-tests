from linear_search_perf import generate_array, benchmark_search

N = 1_000_000_000

print(f"Generating array of {N} integers... and searching for values located at")
print("Technology: Cython")

data = generate_array(N)

benchmark_search(data, N // 100, "0%")
benchmark_search(data, N // 20, "5%")
benchmark_search(data, N * 15 // 100, "15%")
benchmark_search(data, N // 4, "25%")
benchmark_search(data, N // 2, "50%")
benchmark_search(data, N * 3 // 4, "75%")
benchmark_search(data, N - 1, "100%")

