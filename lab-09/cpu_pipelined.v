`include "state_machine.vh"
`include "alu_opsel.vh"

module cpu_pipelined (
	input reset, clk
);

	/*
	* Processor registers. Rd and Rr refer to registers from this array.
	*/
	reg     [7:0] registers[31:0];
	integer       i              ;

	always @(posedge reset) begin
		for (i = 0; i < 32; i = i + 1) begin
			registers[i] = i;
		end
	end

	reg [7:0] program_counter;

	/*
	* These signals don't actually do anything, they are here just for
	* debugging purposes.
	*/
	reg [7:0] program_counter_if ;
	reg [7:0] program_counter_id ;
	reg [7:0] program_counter_ex ;
	reg [7:0] program_counter_mem;
	reg [7:0] program_counter_wb ;

	always @(program_counter) begin
		/*
		* TODO DEBUG: Each instruction must be moved to the next stage. The IF stage
		* must receive a brand new instruction.
		*/
		program_counter_if  <= 8'b0;
		program_counter_id  <= 8'b0;
		program_counter_ex  <= 8'b0;
		program_counter_mem <= 8'b0;
		program_counter_wb  <= 8'b0;
	end

	/*
	* TODO 2: This signal links the IF and ID stages. Because we will be
	* fetching one instruction wile decoding another, we need a buffer for it.
	*/
	wire [31:0] instruction;
	/*
	* TODO 2: We now have a buffer for the instruction signal. Should we send
	* the unbuffered or buffered value to the decoder?
	* Hint: In the pipeline, the unbuffered value of the instruction will be
	* changed by the memory while the decoder is using it because the memory is
	* fetching a new instruction while the decoder is decoding.
	*/
	reg [31:0] instruction_buf;

	memory instruction_memory (
		.data   (instruction    ),
		.address(program_counter),
		.clk    (clk            )
	);

	wire [7:0] op1  ;
	wire [7:0] op2  ;
	wire [2:0] opsel;

	decoder decoder_unit (
		.op1        (op1            ),
		.op2        (op2            ),
		.opsel      (opsel          ),
		.instruction(instruction_buf)
	);

	/*
	* TODO 2: These signals link the ID and EX stages. We need buffers for
	* them.
	*/
	reg  [7:0] alu_A      ;
	reg  [7:0] alu_B      ;
	wire [7:0] alu_R      ;
	reg  [2:0] alu_opsel  ;
	reg  [7:0] alu_address;

	/*
	* TODO 2: We now have buffers for the alu_A, alu_B and alu_opsel signals.
	* Should we send the unbuffered or buffered values to the ALU?
	*/
	alu execution_unit (
		.R    (alu_R    ),
		.A    (alu_A    ),
		.B    (alu_B    ),
		.opsel(alu_opsel)
	);

	/*
	* TODO 2: These signals link the EX and MEM stages. We need buffers for
	* them.
	*/
	reg [7:0] mem_address;
	reg [7:0] mem_value  ;
	/*
	* As we don't have a memory, this is indeed everything the MEM stage does.
	*
	* TODO 2: We now have buffers for the mem_address and mem_value signals.
	* Should we send the unbuffered or buffered values to be written back to
	* registers?
	*/

	/*
	* TODO 2: These signals link the MEM and WB stages. We need buffers for
	* them.
	*/
	reg [7:0] wb_address;
	reg [7:0] wb_value  ;


	always @(*) begin
		/*
		* TODO 2: We need to write back to registers a new value every clock
		* cycle.
		*
		* TODO 2: We now have buffers for the wb_address and wb_value signals.
		* Should we send the unbuffered or buffered values to the be written
		* back to registers?
		*/
		if (wb_address !== 8'hxx) begin
			registers[wb_address] = wb_value;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			program_counter <= 0;
		end else begin
			/*
			* TODO 2: We need a new instruction every clock cycle.
			*/
			program_counter <= 8'b0;

			/*
			* TODO 2: Each stage's output must be moved to the next stage's input
			* buffer (see the buffers you created above).
			*/
			// IF -> ID

			// ID -> EX

			// EX -> MEM

			// MEM -> WB

		end
	end

endmodule
