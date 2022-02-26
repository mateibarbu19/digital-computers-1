/* verilator lint_off UNOPTFLAT */
`include "defines.vh"

module one_adder #(parameter NR_BITS = 4) (
    output [NR_BITS-1:0] sum  ,
    output               c_out,
    input  [NR_BITS-1:0] a
);

    // DONE 1: Implement a 4-bit carry-lookahead adder

    wire [NR_BITS-1:0] carry;
    generate
        genvar i;
        for (i = 0; i < NR_BITS; i = i + 1) begin : carry_logic
            assign #(`DELAY) carry[i] = &a[i:0];
        end
    endgenerate

    assign c_out = carry[NR_BITS-1];

    assign #(`DELAY) sum = a ^ {carry[NR_BITS-2:0], 1'b1};

endmodule
