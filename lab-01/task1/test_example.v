module test_example();

    // Inputs.
    reg in;

    // Outputs.
    /* verilator lint_off UNUSED */
    wire out;
    /* verilator lint_on UNUSED */

    // Initialize Unit Under Test (UUT).
    example some_name (
        .out(out),
        .in(in)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_example);
        // Initialize inputs.
        in = 0;

        // We wait 100 s for the global reset.
        #100;

        // We add stimuli.
        #100 in = 1;
        #100 in = 0;
        #100;
    end

endmodule
