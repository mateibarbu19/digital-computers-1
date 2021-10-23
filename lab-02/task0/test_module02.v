module test_module02();

    // Inputs
    reg in;

    // Outputs
    /* verilator lint_off UNUSED */
    wire out;
    /* verilator lint_off UNUSED */

    // Instantiate the Unit Under Test (UUT)
    module02 uut (
        .out(out), 
        .in(in)
    );

    initial begin
        $dumpfile("waves02.vcd");
        $dumpvars(0, test_module02);
        // Initialize Inputs
        in = 0;
        // Wait 10s for global reset to finish
        #10;

         in = 1;  
        #10;
    end
      
endmodule

