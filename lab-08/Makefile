CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = alu.vvp

.PHONY: build clean

build: $(TARGETS)

alu.vvp: adder.v alu.v multiplier.v one_adder.v subtractor.v test_alu.v
	$(CC) $(FLAGS) -o $@ $^

# one_adder.json: synth_one_adder.ys one_adder.v
# 	yosys $<
# 	sed -i 's#reduce_##g' $@
# 	rm -f *.pid

# ineff_cla_adder.json: ineff_cla_adder.v synth_ineff_cla.ys
# 	yosys synth_ineff_cla.ys
# 	rm -f *.pid

# rpc_adder.json: rpc_adder.v synth_rpc.ys
# 	yosys synth_rpc.ys
# 	rm -f *.pid

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
