`timescale 1ns / 1ps

module full_adder_test ();

    // Inputs
    reg bit_A;
    reg bit_B;
    reg carry_in;

    // Outputs
    wire sum;
    wire carry_out;
    reg ok;

    // Instantiate the Unit Under Test (UUT)
    full_adder uut (
        .sum(sum), 
        .carry_out(carry_out), 
        .bit_A(bit_A), 
        .bit_B(bit_B), 
        .carry_in(carry_in)
    );

    initial begin
        $dumpfile("waves_full_adder.vcd");
        $dumpvars(0, full_adder_test);
        // Initialize Inputs
        bit_A    = 0;
        bit_B    = 0;
        carry_in = 0;
        ok       = 0;

        #1;
        if (sum == 0 && carry_out == 0) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        bit_A = 1;

        #1;		
        if (sum == 1 && carry_out == 0) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        carry_in = 1;
        
        #1;
        if (sum == 0 && carry_out == 1) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        bit_A = 0;
        bit_B = 1;
        
        #1;
        if (sum == 0 && carry_out == 1) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        carry_in = 0;
        
        #1;
        if (sum == 1 && carry_out == 0) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
        
        #99;
        bit_A    = 1;
        carry_in = 1;
        
        #1;
        if (sum == 1 && carry_out == 1) begin
            ok = 1;
        end else begin
            ok = 1'bx;
        end
    end
      
endmodule
