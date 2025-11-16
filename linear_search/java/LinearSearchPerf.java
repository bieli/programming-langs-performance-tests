import java.util.Arrays;

public class LinearSearchPerf {

    static final int N = 1_000_000_000;

    public static int[] generateArray(int size) {
        int[] arr = new int[size];
        for (int i = 0; i < size; i++) {
            arr[i] = i;
        }
        return arr;
    }

    public static int linearSearch(int[] arr, int target) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return i;
            }
        }
        return -1;
    }

    public static void benchmarkSearch(int[] arr, int index, String label) {
        int target = arr[index];
        long start = System.nanoTime();
        int result = linearSearch(arr, target);
        long end = System.nanoTime();
        double elapsedSeconds = (end - start) / 1_000_000_000.0;
        System.out.printf("%s: %.8f seconds%n", label, elapsedSeconds);
    }

    public static void main(String[] args) {
        System.out.printf("Generating array of %d integers... and searching for values located at%n", N);
        System.out.println("Technology: Java");

        int[] data = generateArray(N);

        benchmarkSearch(data, N / 100, "0%");
        benchmarkSearch(data, N / 20, "5%");
        benchmarkSearch(data, (int)((long)N * 15 / 100), "15%");
        benchmarkSearch(data, N / 4, "25%");
        benchmarkSearch(data, N / 2, "50%");
        benchmarkSearch(data, (int)((long)N * 3 / 4), "75%");
        benchmarkSearch(data, N - 1, "100%");
    }
}

