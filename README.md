# programming-langs-performance-tests
Most popular programming languages tests for various operations

## Motivation
One learning plaform to remember some older programming lenguages and teach modern, too.

Outputs: interesting facts/numbers about real programming languages performance to compare with TIOBE index programming languages popularity.

Assumptions: Winner on the market - i.e. in TIOBE programming languages - is not the most performant, but most simplistic to teach (have basic syntax)! 

## How to run?
Nothing complex here:

```bash
make all
```

## Example outputs from vector3 opeartions perf. tests (running the same machine)
```bash
$ make pas/TestVectorsPerf
Technology: Pascal
Addition: 0.4600 seconds
Subtraction: 0.4520 seconds
Cross Product: 0.5200 seconds
Scalar Multiplication: 0.4250 seconds
Normalization: 1.0410 seconds
Angle: 0.2740 seconds

$ make c/test_vector_perf
Technology: ANSI C99
Addition: 0.6209 seconds
Subtraction: 0.6097 seconds
Cross Product: 0.6331 seconds
Scalar Multiplication: 0.5431 seconds
Normalization: 0.6557 seconds
Angle: 2.2121 seconds
```

TODO list:
- [X] Vector3D operations in ANSI C
- [X] Vector3D operations in Pascal/FPC
- [ ] Vector3D operations in C++ 11
- [ ] Vector3D operations in Python
- [ ] Vector3D operations in CPython
- [ ] Vector3D operations in Ada
- [ ] Vector3D operations in Haskell
- [ ] Vector3D operations in Java
- [ ] Vector3D operations in RUST
- [ ] Vector3D operations in TypeScript
- [ ] Vector3D operations in Go
- [ ] Vector3D operations in Zig
- [ ] espose performance results on github pages as interactive graphs from CI Github Actions runs
- [ ] add OSs versions matrix to CI and expose differences on github pages graph
