//`timescale 1ns / 1ps

module test_task4;

    // Inputs.
    reg a;
    reg b;
    reg [0:1] sel;

    // Outputs.
    wire out;

    // Initializing Unit Under Test (UUT).
    task4 UUT (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_task4);
        // Initializing inputs.
        
        // Test for 0 0 selection
        sel[0] = 0;
        sel[1] = 0;
        
        a = 0;
        b = 0;
        #1; // Wait 1s.
        a = 0;
        b = 1;
        #1; // Wait 1s.
        a = 1;
        b = 0;
        #1; // Wait 1s.
        a = 1;
        b = 1;
        #1; // Wait 1s.

        // Test for 0 1 selection
        sel[0] = 0;
        sel[1] = 1;
        
        a = 0;
        b = 0;
        #1; // Wait 1s.
        a = 0;
        b = 1;
        #1; // Wait 1s.
        a = 1;
        b = 0;
        #1; // Wait 1s.
        a = 1;
        b = 1;
        #1; // Wait 1s.

        // Test for 1 0 selection
        sel[0] = 1;
        sel[1] = 0;
        
        a = 0;
        b = 0;
        #1; // Wait 1s.
        a = 0;
        b = 1;
        #1; // Wait 1s.
        a = 1;
        b = 0;
        #1; // Wait 1s.
        a = 1;
        b = 1;
        #1; // Wait 1s.

        // Test for 1 1 selection
        sel[0] = 1;
        sel[1] = 1;
        
        a = 0;
        b = 0;
        #1; // Wait 1s.
        a = 0;
        b = 1;
        #1; // Wait 1s.
        a = 1;
        b = 0;
        #1; // Wait 1s.
        a = 1;
        b = 1;
        #1; // Wait 1s.
	end      
endmodule
