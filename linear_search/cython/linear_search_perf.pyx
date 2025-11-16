# cython: boundscheck=False, wraparound=False, cdivision=True
import time
cimport cython

@cython.boundscheck(False)
@cython.wraparound(False)
def generate_array(int size):
    cdef int[:] arr = cython.view.array(shape=(size,), itemsize=cython.sizeof(int), format="i")
    cdef int i
    for i in range(size):
        arr[i] = i
    return arr

@cython.boundscheck(False)
@cython.wraparound(False)
def linear_search(int[:] arr, int target):
    cdef int i
    for i in range(arr.shape[0]):
        if arr[i] == target:
            return i
    return -1

def benchmark_search(int[:] arr, int index, str label):
    target = arr[index]
    start = time.perf_counter()
    linear_search(arr, target)
    end = time.perf_counter()
    elapsed = end - start
    print(f"{label}: {elapsed:.6f} seconds")

