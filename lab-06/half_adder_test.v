`timescale 1ns / 1ps

module half_adder_test ();

    // Inputs
    reg bit_A;
    reg bit_B;

    // Outputs
    wire sum;
    wire carry;
    /* verilator lint_off UNUSED */
    reg ok;
    /* verilator lint_on UNUSED */

    // Instantiate the Unit Under Test (UUT)
    half_adder uut (
        .sum(sum), 
        .carry(carry), 
        .bit_A(bit_A), 
        .bit_B(bit_B)
    );

    initial begin
        $dumpfile("waves_half_adder.vcd");
        $dumpvars(0, half_adder_test);
        // Initialize Inputs
        bit_A = 0;
        bit_B = 0;
        ok    = 0;
        
        #1;
        if (sum == 0 && carry == 0) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        bit_A = 1;
        
        #1;
        if (sum == 1 && carry == 0) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        bit_A = 0;
        bit_B = 1;
        
        #1;
        if (sum == 1 && carry == 0) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        bit_A = 1;
        
        #1;
        if (sum == 0 && carry == 1) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
    end
      
endmodule
