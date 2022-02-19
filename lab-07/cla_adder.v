/* verilator lint_off UNOPTFLAT */
`define DELAY 4

module cla_adder #(
    parameter NR_BITS = 4
) (
    output [NR_BITS-1:0] sum  ,
    output               c_out,
    input  [NR_BITS-1:0] a    ,
    input  [NR_BITS-1:0] b    ,
    input                c_in
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

    wire [NR_BITS-1:0] carry;
    wire [NR_BITS:0]   partial_or [NR_BITS-1:0];

    generate
        genvar j;
        for (i = 0; i < NR_BITS; i = i + 1) begin : carry_logic
            assign partial_or[i][i + 1] = G[i];
            for (j = i; j >= 0; j = j - 1) begin
                wire tmp = (j == 0) ? c_in : G[j - 1];
                assign #(`DELAY) partial_or[i][j] = &{tmp, P[i:j]};
            end
            assign #(`DELAY) carry[i] = |partial_or[i][i + 1:0];
        end
    endgenerate

    assign c_out = carry[NR_BITS-1];

    assign #(`DELAY) sum = P ^ {carry[NR_BITS-2:0], c_in};

endmodule

