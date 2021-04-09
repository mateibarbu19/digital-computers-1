//`timescale 1ns / 1ps

module test_exemplu;

    // Intrari.
    reg in;

    // Iesiri.
    wire out;

    // Instantiem Unit Under Test (UUT).
    exemplu nume (
        .out(out),
        .in(in)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_exemplu);
        // Initializam intrarile.
        in = 0;

        // Asteptam 100 ns pentru a termina resetul global.
        #100;

        // Adaugam stimuli aici.
        #100 in = 1;
        #100 in = 0;
        #100;
	end

endmodule
