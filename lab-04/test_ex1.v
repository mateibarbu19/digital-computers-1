/* verilator lint_off WIDTH */
//`timescale 1ns / 1ps
`include "lib/defines.vh"

module test_ex1();
    `include "lib/helpers.vh"

    // Inputs
    reg reset;
    reg clk;

    // Outputs
    wire out;
    
    // Checker
    reg [4:0] total;

    // Instantiate the Unit Under Test (UUT)
    ex1 uut (
        .out(out),
        .reset(reset), 
        .clk(clk)
    );

    initial begin
        // Initialize Inputs
        reset = 1;
        clk   = 0;

        // Initialize Checker Vars
        total = 0;

        // Wait 100 ns for global reset to finish
        #(`CLK_PERIOD);
        reset = 0;
        
        if (out != 0) begin
            $write("LED: "); show_LEDs(out, 1); $display("- FAILED");
            $display("Check LED initial state!");
            err_exit(total, `EX1_TOTAL, `EX1_SCORE);
        end else begin
            $write("LED: "); show_LEDs(out, 1); $display("- PASSED");
            total = total + 1;
        end

        #((`LED_TMR + `OUT_SYNC) * `CLK_PERIOD)
        if (out != 1) begin
            $write("LED: "); show_LEDs(out, 1); $display("- FAILED");
            $display("Check LED on state!");
            err_exit(total, `EX1_TOTAL, `EX1_SCORE);
        end else begin
            $write("LED: "); show_LEDs(out, 1); $display("- PASSED");
            total = total + 1;
        end
                
        #((`LED_TMR + `OUT_SYNC) * `CLK_PERIOD)
        if (out != 0) begin
            $write("LED: "); show_LEDs(out, 1); $display("- FAILED");
            $display("Check LED off state!");
            err_exit(total, `EX1_TOTAL, `EX1_SCORE);
        end else begin
            $write("LED: "); show_LEDs(out, 1); $display("- PASSED");
            total = total + 1;
        end
        
        succ_exit(total, `EX1_TOTAL, `EX1_SCORE);
        $finish();
    end
    
    
    always
        #(`CLK_PERIOD / 2) clk = !clk;
      
endmodule

