module module03(
	output reg out,
	input in
	);

	always @(*) begin
		out = !in;
	end

endmodule
