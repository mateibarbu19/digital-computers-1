module test_module03;

	// Inputs
	reg in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	module03 uut (
		.out(out), 
		.in(in)
	);

	initial begin
		$dumpfile("waves03.vcd");
        $dumpvars(0, test_module03);
		// Initialize Inputs
		in = 0;
		// Wait 10s for global reset to finish
		#10;

     	in = 1;  
		#10;
	end
      
endmodule