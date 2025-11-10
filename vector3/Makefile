all: c/test_vector_perf

c/test_vector_perf: c/vector.c c/test_vector_perf.c
	cd c && gcc -std=c99 -O2 vector.c test_vector_perf.c -o test_vector_perf -lm && ./test_vector_perf

run: all
	./c/test_vector_perf

clean:
	rm -f c/*.o c/test_vector_perf
