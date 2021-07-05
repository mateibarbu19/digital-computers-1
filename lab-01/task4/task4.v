module task4(
    input a,
    input b,
    input [0:1] sel,
    output out
);

    // Dataflow programming style.
    assign out =
        (~sel[0] & ~sel[1] & ~(a & b)) |
        (~sel[0] & sel[1] & (a & b)) |
        (sel[0] & ~sel[1] & (a | b)) |
        (sel[0] & sel[1] & (a ^ b));
	
endmodule
