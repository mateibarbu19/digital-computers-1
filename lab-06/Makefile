CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = half_adder.vvp full_adder.vvp full_adder_all.vvp \
		ripple_carry_8bit.vvp subtractor_8bit.vvp ordinator_8bit.vvp

.PHONY: build clean

build: $(TARGETS)

half_adder.vvp: half_adder_test.v half_adder.v half_adder_structural.v \
			half_adder_dataflow.v half_adder_procedural.v
	$(CC) $(FLAGS) -o $@ $^

full_adder.vvp: full_adder_test.v full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@ $^

full_adder_all.vvp: full_adder_all_tests.v full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@ $^

ripple_carry_8bit.vvp: ripple_carry_8bit_test.v ripple_carry_8bit.v full_adder.v \
				half_adder_structural.v
	$(CC) $(FLAGS) -o $@ $^

subtractor_8bit.vvp: subtractor_8bit_test.v subtractor_8bit.v ripple_carry_8bit.v \
				 full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@ $^

ordinator_8bit.vvp: ordinator_8bit_test.v ordinator_8bit.v ripple_carry_8bit.v \
				subtractor_8bit.v full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@ $^

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};          \
	done

clean:
	rm -rf $(TARGETS) waves*.vcd
