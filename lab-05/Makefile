CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = unlock counter unlock2

.PHONY: build clean

build: $(TARGETS)

unlock: unlock.v counter.v unlock_test.v
	$(CC) $(FLAGS) -o $@.vvp $^

unlock2: unlock.v counter.v unlock_test_2.v
	$(CC) $(FLAGS) -o $@.vvp $^

counter: counter.v counter_test.v
	$(CC) $(FLAGS) -o $@.vvp $^

synthesis: synth.ys
	yosys synth.ys
	rm -f *.pid

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry}.vvp;      \
	done

clean:
	rm -rf *.vvp waves*.vcd schematic*.dot *.pid *.json unlock
