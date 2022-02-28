`include "instruction.vh"

module memory (
	output reg [31:0] data   ,
	input      [ 7:0] address,
	input             clk
);

	always @(negedge clk) begin
		case (address)
			/*
			* TODO 1: Add each instruction once. Follow the example given.
			* Note: See the instruction definitions in instruction.vh.
			* Note: To avoid hazards, don't use the same operand twice.
			*/
			8'h00 : data = {`INSTRUCTION_NOP,	8'h00, 8'h00};
			// pay attention to address


			/*
			* TODO 3: Uncomment the following sequence and solve the hazards.
			* Note: You will have to comment out the code you added for Task 1.
			*/
			/*
			8'h00 : data = {`INSTRUCTION_ADD,	8'h02, 8'h01};
			8'h03 : data = {`INSTRUCTION_ADD,	8'h03, 8'h02};
			8'h04 : data = {`INSTRUCTION_SUB,	8'h12, 8'h11};
			8'h07 : data = {`INSTRUCTION_SUB,	8'h12, 8'h13};
			8'h08 : data = {`INSTRUCTION_ADD,	8'h06, 8'h05};
			8'h09 : data = {`INSTRUCTION_SUB,	8'h16, 8'h15};
			8'h0b : data = {`INSTRUCTION_ADD,	8'h07, 8'h06};
			*/

			default : data = {`INSTRUCTION_NOP,	8'h00, 8'h00};
		endcase
	end

endmodule
