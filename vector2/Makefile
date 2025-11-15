all: c/vector2d_perf pas/TestVector2DPerf

c/vector2d_perf: c/vector2d.c c/main.c
	cd c && gcc -O2 main.c vector2d.c -o vector2d_perf -lm && time ./vector2d_perf

pas/TestVector2DPerf:
	cd pas && fpc TestVector2DPerf.pas && time ./TestVector2DPerf

clean:
	rm -f c/*.o c/vector2d_perf
	rm -f pas/*.ppu pas/*.o pas/TestVector2DPerf
