public class VectorPerfTest {
    private static final int ITERATIONS = 100_000_000;

    public static void benchmark(String label, Runnable task) {
        long start = System.nanoTime();
        task.run();
        long end = System.nanoTime();
        double duration = (end - start) / 1e9;
        System.out.printf("%s: %.6f seconds%n", label, duration);
    }

    public static void main(String[] args) {
        Vector v1 = new Vector(1.0, 2.0, 3.0);
        Vector v2 = new Vector(4.0, 5.0, 6.0);

        System.out.printf("Technology: Java%n");
        benchmark("Addition", () -> {
            Vector result;
            for (int i = 0; i < ITERATIONS; i++)
                result = v1.add(v2);
        });

        benchmark("Subtraction", () -> {
            Vector result;
            for (int i = 0; i < ITERATIONS; i++)
                result = v1.subtract(v2);
        });

        benchmark("Cross Product", () -> {
            Vector result;
            for (int i = 0; i < ITERATIONS; i++)
                result = v1.cross(v2);
        });

        benchmark("Scalar Multiplication", () -> {
            Vector result;
            for (int i = 0; i < ITERATIONS; i++)
                result = v1.scale(2.5);
        });

        benchmark("Normalization", () -> {
            Vector result;
            for (int i = 0; i < ITERATIONS; i++)
                result = v1.normalize();
        });

        benchmark("Angle", () -> {
            for (int i = 0; i < ITERATIONS; i++)
                v1.angle(v2);
        });
    }
}

