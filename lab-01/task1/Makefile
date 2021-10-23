CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: example.vvp

example.vvp: example.v test_example.v
	$(CC) $(FLAGS) -o $@ $^

run: example.vvp
	$(SIM) $<

clean:
	rm -rf example.vvp waves.vcd
