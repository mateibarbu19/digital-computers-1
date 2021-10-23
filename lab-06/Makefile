CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = half_adder full_adder full_adder_all ripple_carry_8bit \
		  subtractor_8bit ordinator_8bit

.PHONY: build clean

build: $(TARGETS)

half_adder: half_adder_test.v half_adder.v half_adder_structural.v \
			half_adder_dataflow.v half_adder_procedural.v
	$(CC) $(FLAGS) -o $@.vvp $^

full_adder: full_adder_test.v full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@.vvp $^

full_adder_all: full_adder_all_tests.v full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@.vvp $^

ripple_carry_8bit: ripple_carry_8bit_test.v ripple_carry_8bit.v full_adder.v \
				half_adder_structural.v
	$(CC) $(FLAGS) -o $@.vvp $^

subtractor_8bit: subtractor_8bit_test.v subtractor_8bit.v ripple_carry_8bit.v \
				 full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@.vvp $^

ordinator_8bit: ordinator_8bit_test.v ordinator_8bit.v ripple_carry_8bit.v \
				subtractor_8bit.v full_adder.v half_adder_structural.v
	$(CC) $(FLAGS) -o $@.vvp $^

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry}.vvp;      \
	done

clean:
	rm -rf *.vvp waves*.vcd
