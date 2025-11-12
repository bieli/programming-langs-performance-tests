all: c/test_vector_perf pas/TestVectorsPerf rust/target/release/vector_perf java/VectorPerfTest py/test_vectors_perf

c/test_vector_perf: c/vector.c c/test_vector_perf.c
	cd c && gcc -std=c99 -O2 vector.c test_vector_perf.c -o test_vector_perf -lm && time ./test_vector_perf

pas/TestVectorsPerf: pas/TestVectorsPerf.pas
	cd pas && fpc TestVectorsPerf.pas && time ./TestVectorsPerf

rust/target/release/vector_perf:
	cd rust && cargo build --release && time cargo run --release

java/VectorPerfTest: java/VectorPerfTest
	javac java/Vector.java java/VectorPerfTest.java
	time java -Duser.language=en -Duser.region=US -cp java VectorPerfTest

py/test_vectors_perf:
	time python3 py/test_vectors_perf.py

clean:
	rm -f c/*.o c/test_vector_perf
	rm -f pas/*.ppu pas/*.o pas/TestVectorsPerf
	rm -rf rust/target
	rm -f java/*.class
	find . -name "*.pyc" -delete
	rm -rf py/__pycache__/
