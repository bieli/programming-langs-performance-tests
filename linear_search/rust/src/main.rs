use std::time::Instant;

const N: usize = 1_000_000_000;

fn generate_array(size: usize) -> Vec<usize> {
    let mut data = Vec::with_capacity(size);
    for i in 0..size {
        data.push(i);
    }
    data
}

fn linear_search(arr: &[usize], target: usize) -> Option<usize> {
    for (i, &val) in arr.iter().enumerate() {
        if val == target {
            return Some(i);
        }
    }
    None
}

fn benchmark_search(arr: &[usize], index: usize, label: &str) {
    let target = arr[index];
    let start = Instant::now();
    let result = linear_search(arr, target);
    let duration = start.elapsed().as_secs_f64();
    match result {
        Some(_) => println!("{}: {:.4} seconds", label, duration),
        None => println!("{:<6}: not found in {:.4} seconds", label, duration),
    }
}

fn main() {
    println!("Generating array of {} integers... and searching for values located at", N);
    println!("Technology: Rust");

    let data = generate_array(N);

    benchmark_search(&data, N / 100, "0%");
    benchmark_search(&data, N / 20, "5%");
    benchmark_search(&data, N * 15 / 100, "15%");
    benchmark_search(&data, N / 4, "25%");
    benchmark_search(&data, N / 2, "50%");
    benchmark_search(&data, N * 3 / 4, "75%");
    benchmark_search(&data, N - 1, "100%");
}

