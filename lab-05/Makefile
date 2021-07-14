CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = unlock counter

.PHONY: build clean

build: $(TARGETS)

unlock: unlock.v counter.v unlock_test.v
	$(CC) $(FLAGS) -o $@ $^

counter: counter.v counter_test.v
	$(CC) $(FLAGS) -o $@ $^

run: unlock counter
	$(SIM) unlock
	$(SIM) counter

clean:
	rm -rf $(TARGETS) waves*.vcd
