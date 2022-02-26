/* verilator lint_off UNUSED */

`include "defines.vh"

module alu #(
    parameter NR_BITS = 4
) (
        output  [2*NR_BITS-1:0]  out,
        input   [NR_BITS-1:0]  in0,
        input   [NR_BITS-1:0]  in1,
        input   [4:0]  sel
    );

    wire    [NR_BITS-1:0]  out_nander;
    wire    [NR_BITS-1:0]  out_xorer;
    wire    [NR_BITS-1:0]  out_adder;
    wire    [NR_BITS-1:0]  out_subtractor;
    wire    [2*NR_BITS-1:0]  out_multiplier;

    // DONE: implement NAND
    assign #(`DELAY) out_nander = ~(in0 & in1);

    // DONE: use XOR operator
    assign #(`DELAY) out_xorer = in0 ^ in1;

    // DONE: use adder and put the result in out_adder
    wire adder_c_out;
    adder #(
        .NR_BITS(NR_BITS)
    ) simple_adder (
        .sum(out_adder),
        .c_out(adder_c_out),
        .a(in0        ),
        .b(in1        ),
        .c_in(1'd0    )
    );

    // DONE: use subtractor and put the result in out_subtractor
    wire subtractor_c_out;
    subtractor #(
        .NR_BITS(NR_BITS)
    ) simple_subtractor (
        .diff(out_subtractor),
        .c_out(subtractor_c_out),
        .a(in0        ),
        .b(in1        )
    );

    // DONE: use multiplier and put the result in out_multiplier
    multiplier #(
        .NR_BITS(NR_BITS)
    ) simple_multiplier (
        .out(out_multiplier),
        .M(in0),
        .R(in1)
    );

    // sel == 1 => NAND
    // sel == 2 => XOR
    // sel == 4 => ADD
    // sel == 8 => SUB
    // sel == 16 => MUL
    reg [2*NR_BITS-1:0] out_res;
    always @(*) begin
        case (sel)
            5'd1: out_res = {{NR_BITS{1'b0}}, out_nander};
            5'd2: out_res = {{NR_BITS{1'b0}}, out_xorer};
            5'd4: out_res = {{NR_BITS{1'b0}}, out_adder};
            5'd8: out_res = {{NR_BITS{1'b0}}, out_subtractor};
            5'd16: out_res = out_multiplier;
            default: out_res = {2*NR_BITS{1'bx}};
        endcase
    end
    assign out = out_res;

endmodule
