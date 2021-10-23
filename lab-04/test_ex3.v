/* verilator lint_off WIDTH */
// `timescale 1ns / 1ps
`include "lib/defines.vh"

module test_ex3();
    `include "lib/helpers.vh"
    
    // Inputs
    reg button;
    reg reset;
    reg clk;

    // Outputs
    wire [7:0] out;

    // Checker
    reg [4:0] total;
    
    // Instantiate the Unit Under Test (UUT)
    ex3 uut (
        .out(out), 
        .button_debounced(button), 
        .reset(reset), 
        .clk(clk)
    );

    initial begin
        // Initialize Inputs
        button = 0;
        reset  = 1;
        clk    = 0;
        
        // Initialize Checker Vars
        total = 0;

        // Wait 100 ns for global reset to finish
        #100;
        reset = 0;

        @(out)
        if (out == 0)
            total = total + 1;
        else begin
            $display("Initial state not found! - FAILED");
            err_exit(total, `EX3_TOTAL, `EX3_SCORE);
        end
        
        @(out)
        if (out == 240) begin
            $display("SMPHR: %b - PASSED", out);
            $display("Waiting %0d clock periods...", `SMPHR_RED_TMR);
            total = total + 1;
        end else begin
            $display("SMPHR: %b - FAILED", out);
            $display("Semaphore expected RED light after initialization! - FAILED");
            err_exit(total, `EX3_TOTAL, `EX3_SCORE);
        end
        
        #(`CLK_PERIOD / 2) // desync
        button = 1;
        #(`CLK_PERIOD)
        button = 0;
        
        #((`SMPHR_RED_TMR + `SMPHR_TMR_START + `SMPHR_TMR_STOP + `OUT_SYNC) * `CLK_PERIOD)
        if (out == 15) begin
            $display("SMPHR: %b - PASSED", out);
            $display("Waiting %0d clock periods...", `SMPHR_GRN_TMR);
            total = total + 1;
        end else begin
            $display("SMPHR: %b - FAILED", out);
            $display("Check out value and red-to-green delay!");
            err_exit(total, `EX3_TOTAL, `EX3_SCORE);
        end
        
        #((`SMPHR_GRN_TMR + `SMPHR_TMR_STOP + `OUT_SYNC) * `CLK_PERIOD)
        if (out == 240) begin
            $display("SMPHR: %b - PASSED", out);
            total = total + 1;
        end else begin
            $display("SMPHR: %b - FAILED", out);
            $display("Check out value and green-to-red delay!");
            err_exit(total, `EX3_TOTAL, `EX3_SCORE);
        end
        
        succ_exit(total, `EX3_TOTAL, `EX3_SCORE);

        $finish();
    end
    
    always
        #(`CLK_PERIOD / 2) clk = !clk;
      
endmodule
