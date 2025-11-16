all: c/test_vector_perf cpp/vector_perf pas/TestVectorsPerf rust/target/release/vector_perf java/VectorPerfTest py/test_vectors_perf go/main d/vector3d_perf cython

c/test_vector_perf: c/vector.c c/test_vector_perf.c
	cd c && gcc -std=c99 -O2 vector.c test_vector_perf.c -o test_vector_perf -lm && time ./test_vector_perf

cpp/vector_perf: cpp/vector.cpp cpp/main.cpp
	cd cpp && g++ -std=c++11 -O2 main.cpp vector.cpp -o vector_perf && time ./vector_perf

pas/TestVectorsPerf: pas/TestVectorsPerf.pas
	cd pas && fpc TestVectorsPerf.pas && time ./TestVectorsPerf

rust/target/release/vector_perf:
	cd rust && cargo build --release && time cargo run --release

java/VectorPerfTest: java/VectorPerfTest
	javac java/Vector.java java/VectorPerfTest.java
	time java -Duser.language=en -Duser.region=US -cp java VectorPerfTest

py/test_vectors_perf:
	time python3 py/test_vectors_perf.py

go/main:
	cd go && go build main.go && time ./main

d/vector3d_perf:
	cd d/ && dmd main.d vector3d.d -O -release -inline -of=vector3d_perf && time ./vector3d_perf

cython:
	cd cython/ && python3 -m venv .venv && . .venv/bin/activate && pip3 install cython numpy setuptools && python setup.py build_ext --inplace && time python3 test_vector_perf.py

clean:
	rm -f c/*.o c/test_vector_perf
	rm -f cpp/*.o cpp/vector_perf
	rm -f pas/*.ppu pas/*.o pas/TestVectorsPerf
	rm -rf rust/target
	rm -f java/*.class
	find . -name "*.pyc" -delete
	rm -rf py/__pycache__/
	rm -f go/main
	rm -rf cython/build/ cython/.venv/ cython/*.cpp cython/*.so
	rm -rf d/vector3d_perf d/vector3d_perf.o

