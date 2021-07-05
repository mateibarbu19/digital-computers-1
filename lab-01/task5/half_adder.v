module half_adder(
    input a,
    input b,
    output s,
    output c_out
);

    // Dataflow programming style.
    assign s = a ^ b;
    assign c_out = a & b;

endmodule
