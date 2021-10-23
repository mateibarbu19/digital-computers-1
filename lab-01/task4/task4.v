module task4(
    input a,
    input b,
    input [1:0] sel,
    output out
);
    
    // Dataflow programming style.
    assign out = 
        (~sel[1] & ~sel[0] & ~(a & b)) |
        (~sel[1] &  sel[0] &  (a & b)) |
        ( sel[1] & ~sel[0] &  (a | b)) |
        ( sel[1] &  sel[0] &  (a ^ b));
    
endmodule
