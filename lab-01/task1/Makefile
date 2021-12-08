CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: example.vvp

example.vvp: example.v test_example.v
	$(CC) $(FLAGS) -o $@ $^

waves.vcd: example.vvp
	$(SIM) $<

run: waves.vcd

clean:
	rm -rf example.vvp waves.vcd
