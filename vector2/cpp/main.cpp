#include <iostream>
#include <chrono>
#include <iomanip>
#include "Vector2D.h"

constexpr int ITERATIONS = 100000000;

template<typename Func>
void benchmark(const std::string& label, Func&& func) {
    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < ITERATIONS; ++i) {
        func();
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = end - start;

    std::cout << std::fixed << std::setprecision(7);
    std::cout << label << ": " << elapsed.count() << " seconds\n";
}

int main() {
    Vector2D v1(1.0, 2.0);
    Vector2D v2(3.0, 4.0);

    std::cout << "Technology: CPP\n";

    benchmark("Addition", [&]() { auto r = v1 + v2; });
    benchmark("Subtraction", [&]() { auto r = v1 - v2; });
    benchmark("Scaling", [&]() { auto r = v1 * 2.5; });
    benchmark("Normalization", [&]() { auto r = v1.normalized(); });
    benchmark("Angle", [&]() { auto r = v1.angle(v2); });

    return 0;
}

