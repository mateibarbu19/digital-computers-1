`include "defines.vh"

module multiplier #(
    parameter NR_BITS = 4
) (
    output [2*NR_BITS-1:0] out,
    input  [  NR_BITS-1:0] M  ,
    input  [  NR_BITS-1:0] R
);
    //  Implement Booth's algorithm

    /* verilator lint_off UNOPTFLAT */
    wire [2*NR_BITS:0] P[NR_BITS:0];
    // It is not a reg, it does not have state
    /* verilator lint_on UNOPTFLAT */

    assign P[0] = {{NR_BITS{1'b0}}, R, 1'b0};

    generate
        genvar i;
        for (i = 0; i < NR_BITS; i = i + 1) begin : booth_step
            wire [NR_BITS-1:0] sum ;
            wire [NR_BITS-1:0] diff;
            /* verilator lint_off UNUSED */
            wire adder_c_out     ;
            wire subtractor_c_out;
            /* verilator lint_on UNUSED */

            wire [NR_BITS-1:0] head = P[i][2*NR_BITS:NR_BITS+1];
            wire [  NR_BITS:0] tail = P[i][NR_BITS:0]          ;

            adder #(
                .NR_BITS(NR_BITS)
            ) simple_adder (
                .sum  (sum        ),
                .c_out(adder_c_out),
                .a    (head       ),
                .b    (M          ),
                .c_in (1'd0       )
            );

            subtractor #(
                .NR_BITS(NR_BITS)
            ) simple_subtractor (
                .diff (diff            ),
                .c_out(subtractor_c_out),
                .a    (head            ),
                .b    (M               )
            );

            reg [NR_BITS-1:0] buff;
            always @(*) begin
                case (P[i][1:0])
                    2'b01: buff = sum;
                    2'b10: buff = diff;
                    default: buff = head;
                endcase
            end

            assign #(2*`DELAY) P[i+1] = $signed ({buff, tail}) >>> 1;
            /* the comparators add one delay, plus the multiplexer itself
             * the shift has zero delay because it is done using combinational
             * logic
             */

        end
    endgenerate

    // DONE: assign in out the product of M and R
    assign out = P[NR_BITS][2*NR_BITS:1];

endmodule
