# Digital Computers 1

![sch](lab-05/counter.svg "Laboratory 5, counter module, synthesized and rendered")

Table of Contents
=================

* [Digital Computers 1](#digital-computers-1)
   * [1. Repository description](#1-repository-description)
   * [2. Requirements](#2-requirements)
      * [2.1. Simulation and Synthesis](#21-simulation-and-synthesis)
      * [2.2. Integrated Development Environment](#22-integrated-development-environment)
   * [3. Usage](#3-usage)
   * [4. Other projects](#4-other-projects)
      * [4.1. Linux on Litex](#41-linux-on-litex)
   * [5. Acknowledgments](#5-acknowledgments)

## 1. Repository description

This project aims to provide a fully open-source alternative to the
[Open CourseWare](https://ocw.cs.pub.ro/courses/cn1) Digital Computers 1
Laboratories taught at [Politehnica University of Bucharest](upb.ro).

The official guideline recommends using either the Xilinx ISE or Vivado. Since,
both of them are memory heavy (tens of Gb) and closed-source, this repository
was born in order to prove a change is possible.

Here is the list of the improvements I brought:

- `Makefile` with Icarus Simulator support
- Verilator for linting with all warnings solved
- Correct use of both nonblocking and blocking assignments
    - Wrote an systemized explication about the
    [differences](resources/non-blocking) between the two
- Coding style (as best as I could)
- Improved checkers (e.g. lab-06)
- Removed unsynthesizable `initial` blocks
- Provided information about open-source tools
- Synthesis script (only for some laboratories)

For more information or a syllabus check out the course description
[page here](https://cs.pub.ro/index.php/education/courses/59-under/an2under/116-digital-computers-1).

I encourage you to watch the online lectures
[here](https://www.youtube.com/watch?v=Tr0AdbBRbuk&list=PLwhXkdjzBNZ90g0O0HGMpPg20STiba9Gg).
This course was taught by Dan-Ștefan Tudose.

## 2. Requirements

I do recommend you do read the following tutorial first:
[Running Verilog code on Linux/Mac](https://medium.com/macoclock/running-verilog-code-on-linux-mac-3b06ddcccc55).

### 2.1. Simulation and Synthesis

This project uses [Icarus Verilog](http://iverilog.icarus.com/) for compiling
and simulation. Do note that it was tested only on a Linux platform with
[Make](https://www.gnu.org/software/make/) support. Viewing waveforms can be
done with any program that reads `.vcd` files.

If you would also like to synthesize some of the codes, the only tool I found
was [Yosys](http://www.clifford.at/yosys/). For rendering the generated
schematics you'll need [xdot](https://github.com/jrfonseca/xdot.py) for the
`.dot` files. An alternative is to render the `.json` connection description
with [netlistsvg](https://github.com/nturley/netlistsvg). I recommend you use
the [netlistsvg demo](https://neilturley.dev/netlistsvg/) online without
installing it. (Note: The first example picture in this README was produced by
netlistsvg.)

If you are using a Debian-based system, run the following command to install
the mentioned packages:

```bash
# for building and simulation + waveform viewing
sudo apt install make iverilog gtkwave

# optional, used only for synthesis
# note: depends on xdot
sudo apt install yosys
```

### 2.2. Integrated Development Environment

If you are interested in a IDE, I would recommend
[VSCodium](https://vscodium.com/). Install the Verilog-HDL support for VS Code
[extension](https://github.com/mshr-h/vscode-verilog-hdl-support) (see future
note).
If you are a beginner, the [Verilator](https://www.veripool.org/verilator/) 
linter will provide more educational warnings.

```bash
sudo apt install verilator
```

Go to the extensions settings in VSCodium and configure it like this:

```
# Verilog › Linting: Linter
verilator

# Verilog › Linting › Verilator: Arguments
-Wall -Wno-STMTDLY --bbox-unsup
```

Note: If you took my advice and installed VSCodium, you'll need to enable the VSCode
Marketplace using these
[instructions](https://github.com/VSCodium/vscodium/blob/master/DOCS.md#extensions-marketplace).

## 3. Usage

Open the directory corresponding to the laboratory you want to test. Run
`make build` for compiling, `make run` for simulation, and `gtkwave waves.vcd`
for viewing the resulting waveforms.

Some laboratories, like `lab-05`, include a synthesis script. If
you run `make synthesis` in the respective folder, both a `.dot` and `.json`
file will be generated both containing a logic gate schematic circuit based on
the Verilog code. The `.dot` is opened and rendered by default when running the
script. I shall warn you that the `.json` schematic description contains
multiple module implementations, so when using `netlistsvg` just delete from
the `.json` file the unnecessary ones.

## 4. Other projects

A follow-up to this repository is
[Digital Computers 2](https://github.com/mateibarbu19/digital-computers-2).
Like this repository, it aims to provide a fully open-source alternative to the
[Open CourseWare](https://ocw.cs.pub.ro/courses/cn2) Digital Computers 2
Laboratories (PUB).

During courses we were taught Malvino and Brown's SAP-1 computer architecture.
A very comprehensive repository implementing this architecture can be found
here: <https://github.com/EnigmaCurry/SAP>.

If you are interested in making a Printed Circuit Board out of Verilog code,
check out: <http://pepijndevos.nl/2019/07/18/vhdl-to-pcb.html>.

### 4.1. Linux on Litex

During the 2021 summer I worked along with my teaching assistant, 
[Ștefan-Dan Ciocîrlan](https://github.com/sdcioc), on running Linux on Litex
on a Arty A7-100T development board. I used
[Symbiflow](https://symbiflow.github.io/) as an open-source alternative to
Vivado.

A working project, but old, project can be found on the examples
[repository](https://github.com/SymbiFlow/symbiflow-examples/tree/master/xc7/linux_litex_demo).

Following a more modern project,
[Linux on LiteX with a 64-bit RocketChip CPU](https://github.com/litex-hub/linux-on-litex-rocket),
I tried to compiled the Verilog code for a Rocket CPU implementation, but ran
out of memory since it used more than 120GB of RAM.

Following a lighter project,
[Linux-on-LiteX-VexRiscv](https://github.com/litex-hub/linux-on-litex-vexriscv),
I got Litex up and running flawlessly, but could not manage to run Linux
without errors.

## 5. Acknowledgments

I would like to thank again [Ștefan-Dan Ciocîrlan](https://github.com/sdcioc)
for all his support, this repository would not be possible without him.

Although, they did not contribute directly to making this project, I would like
to thank the following people for their emotional support:

- [Andrei Ionescu](https://github.com/Andrei-Info)
- [Cristian Dima](https://github.com/Cartofie)
- [Marius-Răzvan Pricop](https://github.com/RazorBest)
- [Dimitrie David](https://github.com/dimitriedavid/)
