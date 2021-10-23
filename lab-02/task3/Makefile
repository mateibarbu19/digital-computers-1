CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: module01.vvp

module01.vvp: module01.v test_module01.v
	$(CC) $(FLAGS) -o $@ $^

run: module01.vvp
	$(SIM) module01.vvp

clean:
	rm -rf module01.vvp waves*.vcd
