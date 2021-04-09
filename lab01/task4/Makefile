CC = iverilog
FLAGS = -Wall -Winfloop

.PHONY: build clean

build: task4

task4: task4.v test_task4.v
	$(CC) $(FLAGS) -o $@ $^

run: task4
	vvp $<

clean:
	rm -rf task4 waves.vcd
