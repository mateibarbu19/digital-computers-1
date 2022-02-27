CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = alu.vvp

.PHONY: build clean

build: $(TARGETS)

alu.vvp: adder.v alu.v multiplier.v one_adder.v subtractor.v test_alu.v
	$(CC) $(FLAGS) -o $@ $^

%.json: synth_%.ys %.v
	yosys $<
	sed -i 's#reduce_##g' $@
	rm -f *.pid

synthesis: one_adder.json multiplier.json alu.json

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};          \
	done

clean:
	rm -rf $(TARGETS) *.vcd schematic*.dot *.pid *.json
