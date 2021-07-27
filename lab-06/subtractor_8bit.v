`timescale 1ns / 1ps

module subtractor_8bit (
    output       carry_out,
    output [7:0] result,
    input  [7:0] A,
    input  [7:0] B,
    input carry_in
);

    // result = A - B - carry_in = A + ~B + 1 - carry_in = A + ~B + ~carry_in
    wire       not_C;
    wire [7:0] not_B;

    assign not_B = ~B;
    assign carry_out = ~not_C;

    ripple_carry_8bit rc (
        .carry_out(not_C),
        .sum(result),
        .A(A),
        .B(not_B),
        .carry_in(~carry_in)
    );
    
endmodule
