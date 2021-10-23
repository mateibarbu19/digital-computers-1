`timescale 1ns / 1ps

module half_adder_procedural (
    output reg sum,
    output reg carry,
    input      bit_A,
    input      bit_B
);

    always @(*) begin
        sum   = bit_A ^ bit_B;
        carry = bit_A & bit_B;
    end

endmodule
