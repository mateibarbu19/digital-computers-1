module test_module02();

	// Inputs
	reg i;
	reg j;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	module02 uut (
		.out(out), 
		.a(i),
		.b(j)
	);

	initial begin
		$dumpfile("waves02.vcd");
        $dumpvars(0, test_module02);
		// Initialize Inputs
		i = 0;
		j = 0;
		#10;

		i = 0;
		j = 1;
		#10;

		i = 1;
		j = 0;
		#10;

		i = 1;
		j = 1;
		#10;
	end
      
endmodule