module module01(
    output [3:0] out,
    input [1:0] sel,
    input in
);

    wire [1:0] not_sel;
    not(not_sel[0], sel[0]);
    not(not_sel[1], sel[1]);

    and(out[0], not_sel[1], not_sel[0], in);
    and(out[1], not_sel[1], sel[0], in);
    and(out[2], sel[1], not_sel[0], in);
    and(out[3], sel[1], sel[0], in);

endmodule