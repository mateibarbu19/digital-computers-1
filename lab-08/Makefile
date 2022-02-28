CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = alu.vvp
SCHEMATICS = one_adder.json multiplier.json alu.json multiplier_with_op.json \
				multiplier2.json
SRCS = adder.v alu.v multiplier.v one_adder.v subtractor.v test_alu.v \
			multiplier_with_op.v

.PHONY: build clean

build: $(TARGETS)

alu.vvp: $(SRCS)
	$(CC) $(FLAGS) -o $@ $^

%.json: synth_%.ys %.v
	yosys $<
	sed -i 's#reduce_##g' $@
	rm -f *.pid

synthesis: $(SCHEMATICS)

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};          \
	done

clean:
	rm -rf $(TARGETS) *.vcd schematic*.dot *.pid *.json
