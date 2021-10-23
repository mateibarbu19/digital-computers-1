`timescale 1ns / 1ps

module subtractor_8bit_test ();

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg       carry_in;

	// Outputs
	/* verilator lint_off UNUSED */
	reg        ok;
	wire       carry_out;
	/* verilator lint_on UNUSED */
	wire [7:0] result;

	// Instantiate the Unit Under Test (UUT)
	subtractor_8bit uut (
		.carry_out(carry_out), 
		.result(result), 
		.A(A), 
		.B(B),
		.carry_in(carry_in)
	);

	initial begin
        $dumpfile("waves_subtractor_8bit.vcd");
        $dumpvars(0, subtractor_8bit_test);
		// Initialize Inputs
		A        = 0;
		B        = 0;
		carry_in = 0;
		ok       = 0;

		#1;
      	if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
		
		#99;
		A = 10;
		B = 4;
		
		#1;
		if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
		
		#99;
		B = 0;
		
		#1;
		if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
		
		#99;
		B = 15;
		
		#1;
		if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
		
		#99;
		B = -3;
		
		#1;
		if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
		
		#99;
		A = -10;
		
		#1;
		if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
		
		#99;
		B = 3;
		
		#1;
		if (result == A - B) begin
			ok = 1;
		end else begin
			ok = 1'bx;
		end
	end
      
endmodule
