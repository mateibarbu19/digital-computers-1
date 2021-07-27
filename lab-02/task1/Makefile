CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = module01 module02

.PHONY: build clean

build: module01 module02

module01: module01.v test_module01.v
	$(CC) $(FLAGS) -o $@ $^

module02: module02.v test_module02.v
	$(CC) $(FLAGS) -o $@ $^

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};              \
	done

clean:
	rm -rf module01 module02 waves*.vcd
