`timescale 10ps / 1ps

module ordinator_8bit_test ();

    // Inputs
    reg  [7:0] in;
    wire       ready;
    reg        reset;
    reg        clk;
    reg        ok;

    // Outputs
    wire [7:0] result;

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
        clk   = 0;
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)
        
        
        // Single Operand
        reset = 0; wait(ready) @(posedge clk) // STATE_INITIAL
        
        in = 10;   wait(ready) @(posedge clk)
        in = 2;                @(result)
        if (result == 10) ok = 1; else ok = 1'bx; @(posedge clk)
        
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)
        
        
        // Basic Add
        reset = 0; wait(ready) @(posedge clk) // STATE_INITIAL
        
        in = 10;   wait(ready) @(posedge clk)
        in = 0;    wait(ready) @(posedge clk)
        in = 12;   wait(ready) @(posedge clk)
        in = 2;                @(result)
        if (result == 22) ok = 1; else ok = 1'bx; @(posedge clk)
        
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)
        
        // Basic Sub
        reset = 0; wait(ready) @(posedge clk) // STATE_INITIAL
        
        in = 10;   wait(ready) @(posedge clk)
        in = 1;    wait(ready) @(posedge clk)
        in = 12;   wait(ready) @(posedge clk)
        in = 2;                @(result)
        if (result == 254) ok = 1; else ok = 1'bx; @(posedge clk)
        
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)
        
        
        // Complex Operation
        reset = 0; #1 wait(ready) @(posedge clk) // STATE_INITIAL
        
        in = 10;   #1 wait(ready) @(posedge clk)
        in = 0;    #1 wait(ready) @(posedge clk)
        in = 12;   #1 wait(ready) @(posedge clk)
        in = 1;    #1 wait(ready) @(posedge clk)
        in = 34;   #1 wait(ready) @(posedge clk)
        in = 0;    #1 wait(ready) @(posedge clk)
        in = 7;    #1 wait(ready) @(posedge clk)
        in = 2;                   @(result)
        if (result == 251) ok = 1; else ok = 1'bx; @(posedge clk)
        
        ok    = 1'bz;
        reset = 1;
        @(posedge clk)
        
        
        // Invalid Operator
        reset = 0; #1 wait(ready) @(posedge clk) // STATE_INITIAL
        
        in = 10;   #1 wait(ready) @(posedge clk)
        in = 5;    #1 wait(ready) @(posedge clk)
        in = 0;    #1 wait(ready) @(posedge clk)
        in = 12;   #1 wait(ready) @(posedge clk)
        in = 15;   #1 wait(ready) @(posedge clk)
        in = 8;    #1 wait(ready) @(posedge clk)
        in = 1;    #1 wait(ready) @(posedge clk)
        in = 34;   #1 wait(ready) @(posedge clk)
        in = 0;    #1 wait(ready) @(posedge clk)
        in = 7;    #1 wait(ready) @(posedge clk)
        in = 2;                   @(result)
        if (result == 251) ok = 1; else ok = 1'bx; @(posedge clk)

        $finish();
    end
      
endmodule

