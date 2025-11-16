import std.stdio;
import std.datetime;
import std.array;
import std.format;

immutable size_t N = 1_000_000_000;

ulong linearSearch(ulong[] arr, ulong target) {
    foreach (i, val; arr) {
        if (val == target)
            return i;
    }
    return -1;
}

void benchmarkSearch(ulong[] arr, size_t index, string label) {
    ulong target = arr[index];
    auto start = MonoTime.currTime;
    linearSearch(arr, target);
    auto elapsed = MonoTime.currTime - start;
    writefln("%s: %.8f seconds", label, cast(double)elapsed.total!"nsecs" / 1000000000.0);
}


void main() {
    writeln("Generating array of ", N, " integers... and searching for values located at");
    writeln("Technology: D");

    auto data = new ulong[](N);
    foreach (i; 0 .. N)
        data[i] = i;

    benchmarkSearch(data, N / 100, "0%");
    benchmarkSearch(data, N / 20, "5%");
    benchmarkSearch(data, N * 15 / 100, "15%");
    benchmarkSearch(data, N / 4, "25%");
    benchmarkSearch(data, N / 2, "50%");
    benchmarkSearch(data, N * 3 / 4, "75%");
    benchmarkSearch(data, N - 1, "100%");
}

