CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: task4.vvp

task4.vvp: task4.v test_task4.v
	$(CC) $(FLAGS) -o $@ $^

waves.vcd: task4.vvp
	vvp $<

run: waves.vcd

clean:
	rm -rf task4.vvp waves.vcd
