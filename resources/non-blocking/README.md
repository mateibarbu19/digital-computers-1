# Non-blocking vs. blocking assignaments

In Verilog we think in maybe three different ways:

- Simulation thinking
- FPGA thinking
- ASIC thinking

The differences are important.

The first mindset is based on event driven simulation. To dismiss any event
driven simulation confusion read this link [1].

The second and third ones must be discussed in parallel. When we think about
code that is going to be run on an FPGA or turned into a ASIC, what we are
conceptualizing is synthesizable code, that is code that could be turned into
hardware.

On a ASIC for example `initial` blocks are **not** synthesizable, but on a FPGA
are.

On a FPGA for example combinational logic is generally synthesized using
flip-flops or latches and the internal clock network. Also, a clock signal
cannot be simply connected to any input port, there are some internal
adjustments.

It is generally not, that one who seeks to understand what Verilog code means
learns about the difference between non-blocking and blocking assignments.

---

As I learned from this link [2], non-blocking assignments are the first step
Verilog developers took to solve *non-determinism*.

Why do you need to care? Because an excellent article published by Cummings [3]
shows us that running the same code in different conditions yields different
results. That wouldn't be any good code now would it?

It you read the article or, any of the former links provided and their
references, you might have understood the theoretical difference between them.

---

## The Practical difference

In this folder I have setup a test module `counter` in which I have implemented
have described a hardware as in the following picture:

![sch](counter.svg "Counter schematic")

In `counter.v` I have added two outputs:

- `out_nb`: the output for the non-blocking incrementation
- `out_b`: the output for the non-blocking incrementation

When running the code and reading the waveform we find no difference .


https://stackoverflow.com/a/32854465

[1]: https://electronics.stackexchange.com/questions/202489/event-driven-simulation-confusion

[2]: https://insights.sigasi.com/opinion/jan/verilogs-major-flaw/

[3]: http://www.sunburst-design.com/papers/CummingsSNUG2000SJ_NBA.pdf

