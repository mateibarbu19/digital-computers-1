CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = adder_16.vvp cla_adder.vvp cla_subtractor.vvp rpc_adder.vvp

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

cla_adder.json: cla_adder.v synth_cla.ys
	yosys synth_cla.ys
	sed -i 's#reduce_##g' cla_adder.json cla_adder.json
	rm -f *.pid

ineff_cla_adder.json: ineff_cla_adder.v synth_ineff_cla.ys
	yosys synth_ineff_cla.ys
	rm -f *.pid

rpc_adder.json: rpc_adder.v synth_rpc.ys
	yosys synth_rpc.ys
	rm -f *.pid

synthesis: cla_adder.json ineff_cla_adder.json rpc_adder.json

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};          \
	done

clean:
	rm -rf $(TARGETS) *.vcd schematic*.dot *.pid *.json
