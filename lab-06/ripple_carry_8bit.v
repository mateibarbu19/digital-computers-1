`timescale 1ns / 1ps

module ripple_carry_8bit (
    output       carry_out,
    output [7:0] sum,
    input  [7:0] A,
    input  [7:0] B,
    input        carry_in
);
    
    wire [8:0] carry;
    assign carry[0]  = carry_in;
    assign carry_out = carry[8];

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ripple
            full_adder fa (
                .sum(sum[i]),
                .carry_out(carry[i + 1]),
                .bit_A(A[i]),
                .bit_B(B[i]),
                .carry_in(carry[i])
            );
        end
    endgenerate

endmodule
