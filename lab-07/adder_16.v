module adder_16 (
    output [15:0] sum,
    output        c_out,
    input  [15:0] a,
    input  [15:0] b,
    input         c_in
);

    // DONE 3: implementati un adder pe 16 de biti (Hint: don't write too much code)
    /* verilator lint_off UNOPTFLAT */
    wire [3:0] carry;
    /* verilator lint_on UNOPTFLAT */

    cla_adder #(
        .NR_BITS(4)
    ) CLA_0 (
        .sum  (sum[3:0]),
        .c_out(carry[0]),
        .a    (a[3:0]  ),
        .b    (b[3:0]  ),
        .c_in (c_in    )
    );

    cla_adder #(
        .NR_BITS(4)
    ) CLA_1 (
        .sum  (sum[7:4]),
        .c_out(carry[1]),
        .a    (a[7:4]  ),
        .b    (b[7:4]  ),
        .c_in (carry[0])
    );


    cla_adder #(
        .NR_BITS(4)
    ) CLA_2 (
        .sum  (sum[11:8]),
        .c_out(carry[2] ),
        .a    (a[11:8]  ),
        .b    (b[11:8]  ),
        .c_in (carry[1] )
    );


    cla_adder #(
        .NR_BITS(4)
    ) CLA_3 (
        .sum  (sum[15:12]),
        .c_out(carry[3]  ),
        .a    (a[15:12]  ),
        .b    (b[15:12]  ),
        .c_in (carry[2]  )
    );

    assign c_out = carry[3];

endmodule
