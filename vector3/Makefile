all: c/test_vector_perf pas/TestVectorsPerf

c/test_vector_perf: c/vector.c c/test_vector_perf.c
	cd c && gcc -std=c99 -O2 vector.c test_vector_perf.c -o test_vector_perf -lm && ./test_vector_perf

pas/TestVectorsPerf: pas/TestVectorsPerf.pas
	cd pas && fpc TestVectorsPerf.pas && ./TestVectorsPerf

run: all
	./c/test_vector_perf
	./pas/TestVectorsPerf

clean:
	rm -f c/*.o c/test_vector_perf
	rm -f pas/*.ppu pas/*.o pas/TestVectorsPerf

