#include <iostream>
#include <chrono>
#include "vector.hpp"

const size_t ITERATIONS = 100000000;

template<typename Func>
void benchmark(const std::string& label, Func func) {
    auto start = std::chrono::high_resolution_clock::now();
    func();
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration = end - start;
    std::cout << label << ": " << duration.count() << " seconds\n";
}

int main() {
    Vector v1(1.0, 2.0, 3.0);
    Vector v2(4.0, 5.0, 6.0);

    std::cout << "Technology: CPP\n";
    benchmark("Addition", [&]() {
        Vector result;
        for (size_t i = 0; i < ITERATIONS; ++i)
            result = v1 + v2;
    });

    benchmark("Subtraction", [&]() {
        Vector result;
        for (size_t i = 0; i < ITERATIONS; ++i)
            result = v1 - v2;
    });

    benchmark("Cross Product", [&]() {
        Vector result;
        for (size_t i = 0; i < ITERATIONS; ++i)
            result = v1 * v2;
    });

    benchmark("Scalar Multiplication", [&]() {
        Vector result;
        for (size_t i = 0; i < ITERATIONS; ++i)
            result = v1 * 2.5;
    });

    benchmark("Normalization", [&]() {
        Vector result;
        for (size_t i = 0; i < ITERATIONS; ++i)
            result = v1.normalize();
    });

    benchmark("Angle", [&]() {
        for (size_t i = 0; i < ITERATIONS; ++i)
            v1.angle(v2);
    });

    return 0;
}

