CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = logical_unit debouncer

.PHONY: build clean

build: $(TARGETS)

logical_unit: logical_unit.v logical_unit_test.v
	$(CC) $(FLAGS) -o $@ $^

debouncer: debouncer.v debouncer_test.v
	$(CC) $(FLAGS) -o $@ $^

run: logical_unit debouncer
	$(SIM) logical_unit
	$(SIM) debouncer

clean:
	rm -rf $(TARGETS) waves*.vcd
