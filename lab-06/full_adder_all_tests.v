`timescale 1ns / 1ps

module full_adder_all_tests ();

    // Inputs
    reg [2:0] inputs;

    // Outputs
    /* verilator lint_off UNUSED */
    wire sum;
    wire carry_out;
    /* verilator lint_on UNUSED */

    // Instantiate the Unit Under Test (UUT)
    full_adder uut (
        .sum(sum), 
        .carry_out(carry_out), 
        .bit_A(inputs[0]), 
        .bit_B(inputs[1]), 
        .carry_in(inputs[2])
    );

    initial begin
        $dumpfile("waves_full_adder_all.vcd");
        $dumpvars(0, full_adder_all_tests);
        // Initialize Inputs
        inputs = 0;

        repeat (8) begin
            #100;
            inputs++;
        end
    end
      
endmodule
