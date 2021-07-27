`timescale 1ns / 1ps

module half_adder (
    output sum,
    output carry,
    input  bit_A,
    input  bit_B
);

    wire [2:0] dummy_sum;
    wire [2:0] dummy_carry;	
    
    half_adder_structural structural (
        .sum(dummy_sum[0]),
        .carry(dummy_carry[0]),
        .bit_A(bit_A),
        .bit_B(bit_B)
    );

    half_adder_dataflow dataflow (
        .sum(dummy_sum[1]),
        .carry(dummy_carry[1]),
        .bit_A(bit_A),
        .bit_B(bit_B)
    );

    half_adder_procedural procedural (
        .sum(dummy_sum[2]),
        .carry(dummy_carry[2]),
        .bit_A(bit_A),
        .bit_B(bit_B)
    );

    assign sum = (dummy_sum == 3'b111);
    assign carry = (dummy_carry == 3'b111);

endmodule
