`include "defines.vh"
module multiplier #(parameter NR_BITS = 4) (
    output [2*NR_BITS-1:0] out,
    input  [  NR_BITS-1:0] M  ,
    input  [  NR_BITS-1:0] R
);
    //  Implement Booth's algorithm

    wire [2*NR_BITS:0] A = {M, {NR_BITS+1{1'b0}}}    ;
    wire [2*NR_BITS:0] P [NR_BITS:0]; // It is not a reg, it does not have state

    /* verilator lint_off UNUSED */
    wire [NR_BITS-1:0] adder_c_out;
    wire [NR_BITS-1:0] subtractor_c_out;
    /* verilator lint_on UNUSED */
    wire  [2*NR_BITS:0] sum [NR_BITS-1:0];
    wire  [2*NR_BITS:0] diff [NR_BITS-1:0];

    assign P[0] = {{NR_BITS{1'b0}}, R, 1'b0};

    generate
        genvar i;
        for (i = 0; i < NR_BITS; i = i + 1) begin : booth
            adder #(
                .NR_BITS(2*NR_BITS+1)
            ) simple_adder (
                .sum(sum[i]),
                .c_out(adder_c_out[i]),
                .a(P[i]),
                .b(A),
                .c_in(1'd0    )
            );

            subtractor #(
                .NR_BITS(2*NR_BITS+1)
            ) simple_subtractor (
                .diff(diff[i]),
                .c_out(subtractor_c_out[i]),
                .a(P[i]),
                .b(A)
            );

            assign P[i+1] =
                (P[i][1:0] == 2'b01) ? $signed(sum[i]) >>> 1 :
                (P[i][1:0] == 2'b10) ? $signed(diff[i]) >>> 1 :
                $signed(P[i]) >>> 1;

        end
    endgenerate

    // DONE: assign in out the product of M and R
    assign out = P[NR_BITS][2*NR_BITS:1];

endmodule
