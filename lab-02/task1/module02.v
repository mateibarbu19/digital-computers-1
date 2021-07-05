module module02(
  output reg out,
  input a,
  input b
  );

  always @(*) begin
    if (a == b) begin
      out = 0;
    end else begin
      out = 1;
    end
  end

endmodule
