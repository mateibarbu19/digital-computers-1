CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = unlock.vvp counter.vvp unlock2.vvp

.PHONY: build clean

build: $(TARGETS)

unlock.vvp: unlock.v counter.v unlock_test.v
	$(CC) $(FLAGS) -o $@ $^

unlock2.vvp: unlock.v counter.v unlock_test_2.v
	$(CC) $(FLAGS) -o $@ $^

counter.vvp: counter.v counter_test.v
	$(CC) $(FLAGS) -o $@ $^

connections.json: synth.ys unlock.v
	yosys synth.ys
	rm -f *.pid

synthsis: connections.json

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};          \
	done

clean:
	rm -rf $(TARGETS) waves*.vcd schematic*.dot *.pid *.json
