CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: mux_4_1.vvp

mux_4_1.vvp: mux_4_1.v test_mux_4_1.v
	$(CC) $(FLAGS) -o $@ $^

run: mux_4_1.vvp
	vvp $<

clean:
	rm -rf mux_4_1.vvp waves.vcd
