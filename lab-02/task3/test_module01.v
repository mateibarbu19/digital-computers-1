module test_module01();

    reg clk;
    reg reset;
    /* verilator lint_off UNUSED */
    wire slow_clk;
    /* verilator lint_on UNUSED */

    // Instantiate the Unit Under Test (UUT)
    module01 uut (
        .slow_clk(slow_clk),
        .clk(clk),
        .reset(reset)
    );


    initial begin
        $dumpfile("waves01.vcd");
        $dumpvars(0, test_module01);
        // Initialize Inputs
        clk = 0;
        reset = 1;
        clk = 1;
        #1;
        reset = 0;
        clk = 0;

        repeat (20) begin
            #5 clk = !clk;
        end
    end
      
endmodule