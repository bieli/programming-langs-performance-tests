# Vector2D calc. perf. test in different programming langs.


## Bargraph with results

![](../assets/vector2d__comparision_by_programming_language_1.png)


## Run log with results

```bash
Technology: ANSI C99
Addition: 0.24280200 seconds
Subtraction: 0.12538200 seconds
Scaling: 0.12349200 seconds
Normalization: 0.35481300 seconds
Angle: 1.78305500 seconds


Technology: Pascal/FPC
Addition: 0.311 seconds
Subtraction: 0.294 seconds
Scaling: 0.269 seconds
Normalization: 0.914 seconds
Angle: 4.689 seconds




$ cd rust/
$ rustc main.rs
$ time ./main 
Technology: Rust
Addition: 0.76799014 seconds
Subtraction: 0.64620785 seconds
Scaling: 0.61320496 seconds
Normalization: 1.27767814 seconds
Angle: 4.21457086 seconds

real	0m7,524s
user	0m7,514s
sys	0m0,004s


```
