/* verilator lint_off UNOPTFLAT */
`define DELAY 4

module cla_adder #(
    parameter NR_BITS = 4
) (
    output [NR_BITS-1:0] sum  ,
    output             c_out,
    input  [NR_BITS-1:0] a    ,
    input  [NR_BITS-1:0] b    ,
    input              c_in
);

    // DONE 1: Implement a 4-bit carry-lookahead adder
    wire [NR_BITS-1:0] P, G;

    generate
        genvar i;
        for (i = 0; i < NR_BITS; i = i + 1) begin : generate_propagate_logic
            and #(`DELAY) (G[i], a[i], b[i]);
            xor #(`DELAY) (P[i], a[i], b[i]);
        end
    endgenerate
    // we could have used a or instead of a xor for propagate

    wire [NR_BITS:0] carry;

    assign carry[0] = c_in;
    generate
        for (i = 0; i < NR_BITS; i = i + 1) begin : carry_logic
            assign #(2*`DELAY) carry[i + 1] = G[i] | P[i] & carry[i];
        end
    endgenerate

    assign c_out = carry[NR_BITS];

    assign #(`DELAY) sum = P ^ carry[NR_BITS-1:0];

endmodule

