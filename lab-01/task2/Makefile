CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: other_xor.vvp

other_xor.vvp: other_xor.v test_other_xor.v
	$(CC) $(FLAGS) -o $@ $^

run: other_xor.vvp
	vvp $<

clean:
	rm -rf other_xor.vvp waves.vcd
