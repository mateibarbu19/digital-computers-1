`timescale 1ns / 1ps
`include "lib/defines.vh"

module logical_unit(
		output reg [3:0] res,
		output reg [7:0] select_counter,
		input      [3:0] operand1,
		input      [3:0] operand2,
		input      [1:0] selector,
		input      reset,
		input      clk
    );

	reg [1:0] old_selector;

	always @(posedge clk) begin
		if (reset) begin
			res = 0;
			select_counter = 0;
			old_selector = 0;
		end else begin
			if ((selector[0] != old_selector[0]) && (selector[0] == 1)) begin
				select_counter = select_counter + 1;
			end
			case (selector)
				2'b00: res = operand1 ^ operand2;
				2'b01: res = ~(operand1 & operand2);
				2'b10: res = operand1 | operand2;
				2'b11: res = operand1 & operand2;
				default: res = 2'bxx;
			endcase
			old_selector = selector;
		end
	end

	/*
	 * BONUS: For an easier development, we suggest using a new
    *        procedural block synchronized with the clock.
	 * Hint: Use `SECOND define for counting the clock cycles.
	 */
endmodule
