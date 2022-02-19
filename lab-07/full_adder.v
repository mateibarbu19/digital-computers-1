module full_adder (
    output s    ,
    output c_out,
    input  a    ,
    input  b    ,
    input  c_in
);

    wire s0    ;
    wire c_out0;
    wire c_out1;

    half_adder ha0 (s0, c_out0, a, b);
    half_adder ha1 (s, c_out1, s0, c_in);
    or #4 (c_out, c_out0, c_out1);

endmodule
