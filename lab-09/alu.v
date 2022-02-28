`include "alu_opsel.vh"

module alu (
	output reg [7:0] R    ,
	input      [7:0] A, B ,
	input      [2:0] opsel
);

	always @(*) begin
		case (opsel)
			/*
			* TODO 1: Execute the operation. Follow the example given.
			* Note: See the operation definitions in alu_opsel.vh.
			*/
			`OPSEL_NONE : R = 8'bx;
		endcase
	end

endmodule
