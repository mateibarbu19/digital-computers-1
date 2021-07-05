CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: module01

module01: module01.v test_module01.v
	$(CC) $(FLAGS) -o $@ $^

run: module01
	$(SIM) module01

clean:
	rm -rf module01 waves*.vcd
