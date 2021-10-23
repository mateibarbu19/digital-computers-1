CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: task5.vvp

task5.vvp: half_adder.v full_adder.v test_task5.v
	$(CC) $(FLAGS) -o $@ $^

run: task5.vvp
	vvp $<

clean:
	rm -rf task5.vvp waves.vcd
