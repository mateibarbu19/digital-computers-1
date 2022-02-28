`include "instruction.vh"
`include "alu_opsel.vh"

module decoder (
	output reg [ 7:0] op1        ,
	output reg [ 7:0] op2        ,
	output reg [ 2:0] opsel      ,
	input      [31:0] instruction
);

	always @(*) begin
		case (instruction[31:16])
			/*
			* TODO 1: Decode the instruction and set the outputs. Follow the
			* example given.
			* Note: See the instruction definitions in instruction.vh.
			* Note: You don't need to worry about registers here, just about the
			* values of op1, op2 and opsel. The register selection logic is in
			* the cpu module (see the alu_A and alu_B signals).
			*/
			`INSTRUCTION_NOP : begin
				op1   = 8'bx;
				op2   = 8'bx;
				opsel = `OPSEL_NONE;
			end
		endcase
	end

endmodule
