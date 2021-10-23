CC = iverilog
FLAGS = -Wall -Winfloop
SIM = vvp
TARGETS = module01.vvp module02.vvp module03.vvp

.PHONY: build clean

build: $(TARGETS)

module01.vvp: module01.v test_module01.v
	$(CC) $(FLAGS) -o $@ $^

module02.vvp: module02.v test_module02.v
	$(CC) $(FLAGS) -o $@ $^

module03.vvp: module03.v test_module03.v
	$(CC) $(FLAGS) -o $@ $^

run: $(TARGETS)
	@for entry in $(TARGETS);          \
	do                                 \
		$(SIM) $${entry};              \
	done

clean:
	rm -rf $(TARGETS) waves*.vcd
