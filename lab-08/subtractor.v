`include "defines.vh"

module subtractor #(
    parameter NR_BITS = 4
) (
    output [NR_BITS-1:0] diff ,
    output               c_out,
    input  [NR_BITS-1:0] a    ,
    input  [NR_BITS-1:0] b
);

    // DONE 2: Implement a 4-bit carry-lookahead subtractor

    wire [NR_BITS-1:0] not_b;
    assign #(`DELAY) not_b = ~b;

    adder #(
        .NR_BITS(NR_BITS)
    ) internal_adder (
        .sum  (diff ),
        .c_out(c_out),
        .a    (a    ),
        .b    (not_b),
        .c_in (1'b1 )
    );

endmodule
