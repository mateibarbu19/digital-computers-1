CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: example

example: example.v test_example.v
	$(CC) $(FLAGS) -o $@ $^

run: example
	$(SIM) $<

clean:
	rm -rf example waves.vcd
