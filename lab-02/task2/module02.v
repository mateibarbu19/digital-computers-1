module module02(
    output [3:0] out,
    input [1:0] sel,
    input in
);

  assign out = {sel[1]  & sel[0]  & in,
                sel[1]  & ~sel[0] & in,
                ~sel[1] & sel[0]  & in,
                ~sel[1] & ~sel[0] & in};

endmodule