CC = iverilog
FLAGS = -Wall -Winfloop -I .
SIM = vvp
TARGETS = task1.vvp task2.vvp task3.vvp task4.vvp

.PHONY: build clean

build: $(TARGETS)

task1.vvp: ex1.v test_ex1.v
	$(CC) $(FLAGS) -o $@ $^

task2.vvp: ex2.v test_ex2.v
	$(CC) $(FLAGS) -o $@ $^

task3.vvp: ex3.v test_ex3.v
	$(CC) $(FLAGS) -o $@ $^

task4.vvp: ex4.v test_ex4.v
	$(CC) $(FLAGS) -o $@ $^

run-task1: task1.vvp
	$(SIM) task1.vvp

run-task2: task2.vvp
	$(SIM) task2.vvp

run-task3: task3.vvp
	$(SIM) task3.vvp

run-task4: task4.vvp
	$(SIM) task4.vvp

run: run-task1 run-task2 run-task3 run-task4

clean:
	rm -rf $(TARGETS) *.vcd
