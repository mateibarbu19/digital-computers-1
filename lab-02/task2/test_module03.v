module test_module03;

	// Inputs
	reg in;
	reg [1:0] sel;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	module03 uut (
		.out(out),
		.sel(sel),
		.in(in)
	);

	initial begin
		$dumpfile("waves03.vcd");
        $dumpvars(0, test_module03);
		// Initialize Inputs
		in = 0;
		sel = 2'b00;
		#10;

     	in = 1;
		sel = 2'b00;
		#10;

		in = 0;
		sel = 2'b01;
		#10;

		in = 1;
		sel = 2'b01;
		#10;

		in = 0;
		sel = 2'b10;
		#10;

		in = 1;
		sel = 2'b10;
		#10;

		in = 0;
		sel = 2'b11;
		#10;

		in = 1;
		sel = 2'b11;
		#10;
	end
      
endmodule