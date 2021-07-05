module module01(
  output reg slow_clk,
  input clk,
  input reset
  );

  always @(posedge clk) begin
    if (reset) begin
      slow_clk = 0;
    end else begin
      slow_clk = ~slow_clk;
    end
  end

endmodule