`timescale 1ns / 1ps
`include "lib/defines.vh"

module logical_unit_test;
`include "lib/helpers.vh"

	// Inputs
	reg [3:0] operand1;
	reg [3:0] operand2;
	reg [1:0] selector;
	reg reset;
	reg clock;

	// Outputs
	wire [7:0] select_counter;
	wire [3:0] res;

	// Instantiate the Unit Under Test (UUT)
	logical_unit uut (
		.res(res),
		.select_counter(select_counter),
		.operand1(operand1), 
		.operand2(operand2), 
		.selector(selector), 
		.reset(reset), 
		.clk(clock)
	);
	
	always begin
		#`CLK_PERIOD clock = ~clock;
	end

	initial begin
		$dumpfile("waves_logical_unit.vcd");
        $dumpvars(0, logical_unit_test);

		reset = 0;
		offset = 0;
		operand1 = 0;
		operand2 = 0;
		selector = 0;
		press_reset = 0;
		clock = 0;
		
		// Reset the circuit
		press_reset = 1;
		#(`BTN_PRESSED_CYCLES * `CLK_PERIOD);
		press_reset = 0;
        
		// TEST1: Checking XOR
		operand1 = 4'b1010;
		operand2 = 4'b1111;
		selector = 2'b00;
		#(`TIME_TO_OUTPUT * `CLK_PERIOD);
		check_test(res, 4'b0101, 1, 0);
		
		// TEST2: Checking NAND
		operand1 = 4'b0110;
		operand2 = 4'b1001;
		selector = 2'b01;
		#(`TIME_TO_OUTPUT * `CLK_PERIOD);
		check_test(res, 4'b1111, 2, 0);
		
		// TEST3: Checking OR
		operand1 = 4'b1010;
		operand2 = 4'b0100;
		selector = 2'b10;
		#(`TIME_TO_OUTPUT * `CLK_PERIOD);
		check_test(res, 4'b1110, 3, 0);
		
		// TEST4: Checking AND
		operand1 = 4'b1010;
		operand2 = 4'b1010;
		selector = 2'b11;
		#(`TIME_TO_OUTPUT * `CLK_PERIOD);
		check_test(res, 4'b1010, 4, 0);

		// TEST5: Checking the number of changes of select bit 0
		check_test(select_counter, 2, 5, 1);

		$finish();
	end
	
	
	/*
	 * Button press emulation
	 */
	reg [4:0] offset;
	reg       press_reset;
	always @(clock) begin
		if (press_reset) begin
			if ((offset < `BTN_PRESS_THLD) | (offset > `BTN_RELEASE_THLD)) begin
				reset = ~reset;
			end else begin
				reset = 1;
			end;
			
			offset = offset + 1;
		end else begin
			offset = 0;
		end
	end
      
endmodule

