CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp

.PHONY: build clean

build: counter

counter: test_counter.v counter.v
	$(CC) $(FLAGS) -o $@.vvp $^

synthesis: synth.ys
	yosys synth.ys
	rm -f *.pid

waves.vcd: counter
	$(SIM) $<.vvp

run: waves.vcd

clean:
	rm -rf counter.vvp waves.vcd schematic*.dot *.pid *.json dummy.v
