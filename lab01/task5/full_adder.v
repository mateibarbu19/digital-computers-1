module full_adder(
    input a,
    input b,
    input c_in,
    output s,
    output c_out
);

    // Dataflow programming style.
    
    assign s = (a ^ b) ^ c_in;
    assign c_out = ((a ^ b) & c_in) | (a & b);

endmodule
