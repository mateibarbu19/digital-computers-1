CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
SCHEMATICS = connections.json ideal_counter.json

.PHONY: build clean

build: counter

counter: test_counter.v counter.v
	$(CC) $(FLAGS) -o $@.vvp $^

connections.json: synth.ys counter.v
	yosys synth.ys
	rm -f *.pid

ideal_counter.json: ideal_counter.v
	yosys -p "prep -top ideal_counter; write_json ideal_counter.json" ideal_counter.v

synthesis: $(SCHEMATICS)

waves.vcd: counter
	$(SIM) $<.vvp

run: waves.vcd

clean:
	rm -f counter.vvp waves.vcd schematic*.dot *.pid *.json
