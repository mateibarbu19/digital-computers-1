module other_xor(
    output out,
    input in0,
    input in1
);
    
    wire x0;
    wire x1;
    
    or(x0, in0, in1);
    nand(x1, in0, in1);
    and(out, x0, x1);
    
endmodule
