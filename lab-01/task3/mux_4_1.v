module mux_4_1(
    output out,
    input in0,
    input in1,
    input in2,
    input in3,
    input sel0,
    input sel1
);

    wire notsel0;
    wire notsel1;
    wire y0;
    wire y1;
    wire y2;
    wire y3;

    not(notsel0, sel0);
    not(notsel1, sel1);

    and(y0, in0, notsel1, notsel0);
    and(y1, in1, notsel1, sel0);
    and(y2, in2, sel1, notsel0);
    and(y3, in3, sel1, sel0);

    or(out, y0, y1, y2, y3);

endmodule