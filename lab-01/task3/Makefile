CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: mux_4_1

mux_4_1: mux_4_1.v test_mux_4_1.v
	$(CC) $(FLAGS) -o $@ $^

run: mux_4_1
	vvp $<

clean:
	rm -rf mux_4_1 waves.vcd
