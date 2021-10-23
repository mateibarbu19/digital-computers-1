CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = logical_unit.vvp debouncer.vvp

.PHONY: build clean

build: $(TARGETS)

logical_unit.vvp: logical_unit.v logical_unit_test.v
	$(CC) $(FLAGS) -o $@ $^

debouncer.vvp: debouncer.v debouncer_test.v
	$(CC) $(FLAGS) -o $@ $^

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};              \
	done

clean:
	rm -rf $(TARGETS) waves*.vcd
