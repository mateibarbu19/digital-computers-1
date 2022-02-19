module rpc_adder #(
    parameter NR_BITS = 4
) (
    output [NR_BITS-1:0] sum  ,
    output                c_out,
    input  [NR_BITS-1:0] a    ,
    input  [NR_BITS-1:0] b    ,
    input                 c_in
);

    // DONE 4: Implement a 4-bit ripple-carry adder

    /* verilator lint_off UNOPTFLAT */
    wire [NR_BITS:0] carry;
    /* verilator lint_on UNOPTFLAT */
    assign carry[0] = c_in;
    assign c_out    = carry[NR_BITS];

    genvar i;
    generate
        for (i = 0; i < NR_BITS; i = i + 1) begin : ripple
            full_adder fa (
                .s    (sum[i]    ),
                .c_out(carry[i+1]),
                .b    (b[i]      ),
                .a    (a[i]      ),
                .c_in (carry[i]  )
            );
        end
    endgenerate

endmodule
