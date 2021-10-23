`timescale 10ps / 1ps

module ordinator_8bit_test ();

    // Inputs
    reg  [7:0] in;
    reg        reset;
    reg        clk;

    // Outputs
    /* verilator lint_off UNUSED */
    reg        ok;

    wire       ready;
    wire [7:0] result;
    /* verilator lint_off UNUSED */

    // Instantiate the Unit Under Test (UUT)
    ordinator_8bit uut (
        .result(result), 
        .in(in), 
        .reset(reset), 
        .clk(clk),
        .ready(ready)
    );
    
    always
        #50 clk = ~clk;

    initial begin
        $dumpfile("waves_ordinator_8bit.vcd");
        $dumpvars(0, ordinator_8bit_test);
        // Initialize Inputs
        in    = 0;
        clk   = 1;
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)

        // Single Operand
		reset = 0; 
        wait(ready)
		in = 10;
        wait(!ready)
        @(posedge clk) // STATE_INITIAL
		
        wait(ready) 
		in = 2;
        wait(!ready)
        @(posedge clk)
        @(result)
		if (result == 10) ok = 1; else ok = 1'bx; @(posedge clk)
        
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)

        // Basic Add
		reset = 0;
        wait(ready)
        in = 10;
        wait(!ready)
        @(posedge clk) // STATE_INITIAL
		
        wait(ready)
        in = 0;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 12;
        wait(!ready)
        @(posedge clk)
		 
        wait(ready)
        in = 2;
        wait(!ready)
        @(posedge clk)
        @(result)
		if (result == 22) ok = 1; else ok = 1'bx; @(posedge clk)
       
		ok = 1'bz;
		reset = 1;
		@(posedge clk)
        
        // Basic Sub
        reset = 0; 
        wait(ready)
        in = 10;
        wait(!ready)
        @(posedge clk) // STATE_INITIAL
        
        
        wait(ready)
        in = 1;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 12;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 2;
        wait(!ready)
        @(posedge clk)
		@(result)
		if (result == 254) ok = 1; else ok = 1'bx; @(posedge clk)
		
		ok = 1'bz;
		reset = 1;
		@(posedge clk)
        
        
        // Complex Operation
        reset = 0; 
        
        wait(ready)
        in = 10;
        wait(!ready)
        @(posedge clk)
        
        wait(ready)
        in = 0;
        wait(!ready)
        @(posedge clk)
        
        wait(ready)
        in = 12;
        wait(!ready)
        @(posedge clk)
        
        wait(ready)
        in = 1;
        wait(!ready)
        @(posedge clk)
		
        
        wait(ready)
        in = 34;
        wait(!ready)
        @(posedge clk)
        
        
        
        wait(ready)
        in = 0;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 7;
        wait(!ready)
        @(posedge clk)
        
        
        
        wait(ready)
        in = 2;
        wait(!ready)
        @(posedge clk)
        @(result)
		if (result == 251) ok = 1; else ok = 1'bx; @(posedge clk)
		
		ok = 1'bz;
		reset = 1;
		@(posedge clk)
        
        
        // Invalid Operator
        reset = 0; 
        
        
        wait(ready)
        in = 10;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 5;
        // wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 0;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 12;
        wait(!ready)
        @(posedge clk)
		
        
        wait(ready)
        in = 15;
        // wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 8;
        // wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 1;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 34;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 0;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 7;
        wait(!ready)
        @(posedge clk)
        
        
        wait(ready)
        in = 2;
        wait(!ready)
        @(posedge clk)
        
        @(result)
		if (result == 251) ok = 1; else ok = 1'bx;
        #100;

        $finish();
    end
      
endmodule

