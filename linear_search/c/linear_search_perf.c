#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#define N 1000000000UL

int* generate_array(size_t size) {
    int* arr = calloc(size, sizeof(int));
    if (!arr) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    for (size_t i = 0; i < size; ++i)
        arr[i] = (int)i;
    return arr;
}

int linear_search(int* arr, size_t size, int target) {
    for (size_t i = 0; i < size; ++i)
        if (arr[i] == target)
            return (int)i;
    return -1;
}

void benchmark_search(int* arr, size_t size, size_t index, const char* label) {
    int target = arr[index];
    clock_t start = clock();
    linear_search(arr, size, target);
    clock_t end = clock();
    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%s: %.8f seconds\n", label, elapsed);
}

int main() {
    printf("Generating array of %lu integers... and searching for values located at\n", (unsigned long)N);
    printf("Technology: ANSI C99\n");

    int* data = generate_array(N);

    benchmark_search(data, N, N / 100, "0%");         // 0%
    benchmark_search(data, N, N / 20, "5%");          // 5%
    benchmark_search(data, N, (size_t)N * 15 / 100, "15%"); // 15%
    benchmark_search(data, N, N / 4, "25%");          // 25%
    benchmark_search(data, N, N / 2, "50%");          // 50%
    benchmark_search(data, N, (size_t)N * 3 / 4, "75%");    // 75%
    benchmark_search(data, N, N - 1, "100%");         // 100%

    free(data);
    return 0;
}

