module half_adder (
    output s,
    output c,
    input  a,
    input  b
);

    xor #4 (s, a, b);
    and #4 (c, a, b);

endmodule
