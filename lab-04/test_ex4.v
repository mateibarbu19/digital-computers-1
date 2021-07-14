// `timescale 1ns / 1ps
`include "lib/defines.vh"

module test_ex4();
    `include "lib/helpers.vh"

    // Inputs
    reg A;
    reg G;
    reg C;
    reg T;
    reg reset;
    reg clk;

    // Outputs
    wire mutant;
    //wire super_mutant;
    wire [2:0] current_state;

    // Checker
    reg [4:0] total;
    
    // Instantiate the Unit Under Test (UUT)
    ex4 uut (
        .mutant(mutant), 
        //.super_mutant(super_mutant),
        .currentState(current_state),
        .A_debounced(A), 
        .G_debounced(G), 
        .C_debounced(C), 
        .T_debounced(T), 
        .reset(reset), 
        .clk(clk)
    );

    initial begin
        // Initialize Inputs
        A     = 0;
        G     = 0;
        C     = 0;
        T     = 0;
        reset = 1;
        clk   = 0;
        
        // Initialize Checker Vars
        total = 0;

        // Wait 100 ns for global reset to finish
        #(`CLK_PERIOD)
        if (mutant == 0 && current_state == 0)
            total = total + 1;
        else begin
            $display("Expecting STATE_0 as current state after reset! - FAILED");
            err_exit(total, `EX4_TOTAL, `EX4_SCORE);
        end
        reset = 0;
        
        G = 1;
        #(`CLK_PERIOD)
        if (mutant == 0 && current_state == 1)
            total = total + 1;
        else begin
            $display("Expecting STATE_1 as current state for 'G' input string! - FAILED");
            err_exit(total, `EX4_TOTAL, `EX4_SCORE);
        end
        
        G = 0;
        #(`CLK_PERIOD)
        
        G = 1;
        #(`CLK_PERIOD)
        if (mutant == 0 && current_state == 2)
            total = total + 1;
        else begin
            $display("Expecting STATE_2 as current state for 'GG' input string! - FAILED");
            err_exit(total, `EX4_TOTAL, `EX4_SCORE);
        end
        
        T = 1;
        G = 0;
        #(`CLK_PERIOD)
        if (mutant == 0 && current_state == 3)
            total = total + 1;
        else begin
            $display("Expecting STATE_3 as current state for 'GGT' input string! - FAILED");
            err_exit(total, `EX4_TOTAL, `EX4_SCORE);
        end
        
        T = 0;
        C = 1;
        #(3 * `CLK_PERIOD)
        C = 0;
        
        if (mutant == 1)
            total = total + 1;
        else begin
            $display("Mutant should be found for 'GGTC' input string! - FAILED");
            err_exit(total, `EX4_TOTAL, `EX4_SCORE);
        end
        
        if (mutant == 1 && current_state == 4)
            total = total + 1;
        else begin
            $display("Expecting STATE_4 as current state for 'GGTC' input string! - FAILED");
            err_exit(total, `EX4_TOTAL, `EX4_SCORE);
        end
        
        succ_exit(total, `EX4_TOTAL, `EX4_SCORE);

        $finish();
    end
    always begin
        #(`CLK_PERIOD / 2) clk = ~clk;
    end
      
endmodule
