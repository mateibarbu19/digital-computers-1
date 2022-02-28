CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = cpu.vvp
SCHEMATICS =
SRCS = alu.v cpu_pipelined.v cpu.v decoder.v memory.v test_cpu.v

.PHONY: build clean

build: $(TARGETS)

cpu.vvp: $(SRCS)
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
