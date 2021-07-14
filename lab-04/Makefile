CC = iverilog
FLAGS = -Wall -Winfloop -I .
SIM = vvp
TARGETS = task1 task2 task3 task4

.PHONY: build clean

build: $(TARGETS)

task1: ex1.v test_ex1.v
	$(CC) $(FLAGS) -o $@ $^

task2: ex2.v test_ex2.v
	$(CC) $(FLAGS) -o $@ $^

task3: ex3.v test_ex3.v
	$(CC) $(FLAGS) -o $@ $^

task4: ex4.v test_ex4.v
	$(CC) $(FLAGS) -o $@ $^

run-task1: task1
	$(SIM) task1

run-task2: task2
	$(SIM) task2

run-task3: task3
	$(SIM) task3

run-task4: task4
	$(SIM) task4

run: run-task1 run-task2 run-task3 run-task4
clean:
	rm -rf $(TARGETS) *.vcd
