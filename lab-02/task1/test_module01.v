module test_module01();

    // Inputs
    reg i;
    reg j;

    // Outputs
    /* verilator lint_off UNUSED */
    wire out;
    /* verilator lint_off UNUSED */

    // Instantiate the Unit Under Test (UUT)
    module01 uut (
        .out(out), 
        .a(i),
        .b(j)
    );

    initial begin
        $dumpfile("waves01.vcd");
        $dumpvars(0, test_module01);
        // Initialize Inputs
        i = 0;
        j = 0;
        #10;

        i = 0;
        j = 1;
        #10;

        i = 1;
        j = 0;
        #10;

        i = 1;
        j = 1;
        #10;
    end
      
endmodule