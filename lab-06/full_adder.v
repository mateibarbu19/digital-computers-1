`timescale 1ns / 1ps

module full_adder (
    output sum,
    output carry_out,
    input  bit_A,
    input  bit_B,
    input  carry_in
);

    wire fst_sum;
    wire fst_carry;
    wire snd_carry;

    half_adder_structural adder_1 (
        .sum(fst_sum),
        .carry(fst_carry),
        .bit_A(bit_A),
        .bit_B(bit_B)
    );

    half_adder_structural adder_2 (
        .sum(sum),
        .carry(snd_carry),
        .bit_A(fst_sum),
        .bit_B(carry_in)
    );

    or(carry_out, fst_carry, snd_carry);

endmodule
