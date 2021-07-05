module module03(
  output reg [3:0] out,
  input [1:0] sel,
  input in
  );

  always @(*) begin
	out = 4'b0000;
    case (sel)
      0 : out[0] = in;
      1 : out[1] = in;
      2 : out[2] = in;
      3 : out[3] = in;
      default: out[3:0] = 4'bx;
    endcase
  end

endmodule