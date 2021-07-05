CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: exemplu

exemplu: exemplu.v test_exemplu.v
	$(CC) $(FLAGS) -o $@ $^

run: exemplu
	$(SIM) $<

clean:
	rm -rf exemplu waves.vcd
