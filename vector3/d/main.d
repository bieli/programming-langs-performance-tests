import std.stdio;
import std.datetime.stopwatch;
import vector3d;
import std.format : format;

enum iterations = 100_000_000;

void benchmark(string label, void delegate() op) {
    auto sw = StopWatch(AutoStart.yes);
    op();
    sw.stop();
    auto elapsedNanos = sw.peek.total!"nsecs";
    double elapsedSecs = cast(double)elapsedNanos / 1e9;
    writeln(format("%s: %.8f seconds", label, elapsedSecs));
}

void main() {
    Vector3D v1 = Vector3D(1, 2, 3);
    Vector3D v2 = Vector3D(4, 5, 6);
    Vector3D result;
    double angleResult;

    writeln("Technology: D");
    benchmark("Addition", {
        foreach (_; 0 .. iterations)
            result = v1 + v2;
    });

    benchmark("Subtraction", {
        foreach (_; 0 .. iterations)
            result = v1 - v2;
    });

    benchmark("Cross Product", {
        foreach (_; 0 .. iterations)
            result = v1.cross(v2);
    });

    benchmark("Scalar Multiplication", {
        foreach (_; 0 .. iterations)
            result = v1 * 2.5;
    });

    benchmark("Normalization", {
        foreach (_; 0 .. iterations)
            result = v1.normalize();
    });

    benchmark("Angle", {
        foreach (_; 0 .. iterations)
            angleResult = v1.angle(v2);
    });
}

