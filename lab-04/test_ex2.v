// `timescale 1ns / 1ps
`include "lib/defines.vh"

module test_ex2();
    `include "lib/helpers.vh"

    // Inputs
    reg reset;
    reg clk;

    // Outputs
    wire [7:0] out;
    wire [3:0] state;

    // Checker
    reg [4:0] total;
    reg [4:0] exp_state;
    reg [7:0] correct_out;

    // Instantiate the Unit Under Test (UUT)
    ex2 uut (
        .out(out), 
        .currentState(state), 
        .reset(reset), 
        .clk(clk)
    );

    initial begin
        // Initialize Inputs
        reset = 0;
        clk   = 0;

        // Wait 100 ns for global reset to finish
        #(`CLK_PERIOD / 2)
        reset = 1;
        #(`CLK_PERIOD)
        reset = 0;
        
        // Initialize Checker Vars
        total = 0;
        
        wait(state == 0);
        if (out != 0) begin
            $display("Initial state not found! - FAILED");
            err_exit(total, `EX2_TOTAL, `EX2_SCORE);
        end;
        
        for (exp_state = 1; exp_state < 16; exp_state = exp_state + 1) begin
            wait(state == exp_state) @(out);
            exp_output(exp_state, correct_out);
            if (out != correct_out) begin
                show_LEDs(out, 8);
                $display(" : t%d - FAILED", exp_state);
            end else begin
                show_LEDs(out, 8);
                $display(" : t%d - PASSED", exp_state);
                total = total + 1;
            end;
        end;
        
        @(state);
        if (state != 1)
            $display("The machine did not go back to first state. - FAILED");
        else
            total = total + 1;		
            
        #(`CLK_PERIOD / 2)
        reset = 1;
        #(`CLK_PERIOD)
        
        if (state != 0)
            $display("The machine did not change at reset. - FAILED");
        else
            total = total + 1;
            
        reset = 0;
        
        succ_exit(total, `EX2_TOTAL, `EX2_SCORE);
        
        $finish();
    end
    
    always
        #(`CLK_PERIOD / 2) clk = !clk;
      
endmodule
