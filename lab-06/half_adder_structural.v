`timescale 1ns / 1ps

module half_adder_structural (
    output sum,
    output carry,
    input  bit_A,
    input  bit_B
);
  
    xor(sum, bit_A, bit_B);
    and(carry, bit_A, bit_B);

endmodule
