CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: other_xor

other_xor: other_xor.v test_other_xor.v
	$(CC) $(FLAGS) -o $@ $^

run: other_xor
	vvp $<

clean:
	rm -rf other_xor waves.vcd
