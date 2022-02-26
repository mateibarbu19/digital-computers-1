CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = adder_16.vvp cla_adder.vvp cla_subtractor.vvp rpc_adder.vvp \
			ineff_cla_adder.vvp

.PHONY: build clean

build: $(TARGETS)

rpc_adder.vvp: half_adder.v full_adder.v rpc_adder.v rpc_adder_test.v
	$(CC) $(FLAGS) -o $@ $^

cla_adder.vvp: cla_adder.v cla_adder_test.v
	$(CC) $(FLAGS) -o $@ $^

ineff_cla_adder.vvp: ineff_cla_adder.v cla_adder_test.v
	$(CC) $(FLAGS) -o $@ $^

cla_subtractor.vvp: cla_adder.v cla_subtractor.v cla_subtractor_test.v
	$(CC) $(FLAGS) -o $@ $^

adder_16.vvp: cla_adder.v adder_16.v adder_16_test.v
	$(CC) $(FLAGS) -o $@ $^

%.json: synth_%.ys %.v
	yosys $<
	sed -i 's#reduce_##g' $@
	rm -f *.pid

synthesis: cla_adder.json ineff_cla_adder.json rpc_adder.json

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};          \
	done

clean:
	rm -rf $(TARGETS) *.vcd schematic*.dot *.pid *.json
