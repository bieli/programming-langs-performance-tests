all: c/test_vector_perf pas/TestVectorsPerf rust/target/release/vector_perf java/VectorPerfTest

c/test_vector_perf: c/vector.c c/test_vector_perf.c
	cd c && gcc -std=c99 -O2 vector.c test_vector_perf.c -o test_vector_perf -lm && ./test_vector_perf

pas/TestVectorsPerf: pas/TestVectorsPerf.pas
	cd pas && fpc TestVectorsPerf.pas && ./TestVectorsPerf

rust/target/release/vector_perf:
	cd rust && cargo build --release && cargo run --release

java/VectorPerfTest: java/VectorPerfTest
	javac java/Vector.java java/VectorPerfTest.java
	java -Duser.language=en -Duser.region=US -cp java VectorPerfTest

run: all
	./c/test_vector_perf
	./pas/TestVectorsPerf
	./rust/target/release/vector_perf

clean:
	rm -f c/*.o c/test_vector_perf
	rm -f pas/*.ppu pas/*.o pas/TestVectorsPerf
	rm -rf rust/target
	rm -f java/*.class
