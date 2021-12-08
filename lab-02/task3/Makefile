CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: module01.vvp

module01.vvp: module01.v test_module01.v
	$(CC) $(FLAGS) -o $@ $^

waves01.vcd: module01.vvp
	$(SIM) module01.vvp

run: waves01.vcd

clean:
	rm -rf module01.vvp waves*.vcd
