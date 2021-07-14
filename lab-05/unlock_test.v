// `timescale 1ns / 1ps

module unlock_test();
    
    // Inputs
    reg [7:0] ascii_in;
    reg       reset;
    reg       clk;
    
    // Outputs
    wire out;
    
    // Instantiate the Unit Under Test (UUT)
    unlock unlock (ascii_in, out, reset, clk);
    
    always@(clk)
        #5 clk <= ~clk;
    
    initial begin
        $dumpfile("waves_unlock.vcd");
        $dumpvars(0, unlock_test);

        // Initialize Inputs
        ascii_in = 0;
        reset    = 1;
        clk      = 0;
        
        // Wait 100 ns for global reset to finish
        #98;
        reset    = 0;
        ascii_in = "D";
        #10
        ascii_in = "C";
        #10
        ascii_in = "B";
        #10
        ascii_in = "T";
        #50
        ascii_in = "A";
        #10
        ascii_in = "B";
        #10
        ascii_in = "C";
        #10
        ascii_in = "A";
        #10
        ascii_in = "C";
        #10
        ascii_in = "B";
        #10
        ascii_in = "D";
        #10
        ascii_in = "C";
        #10
        ascii_in = "A";
        #10
        ascii_in = "C";
        #10
        ascii_in = "B";
        #10
        ascii_in = "D";
        #10
        ascii_in = "C";
        #10
        ascii_in = "A";
        #10
        ascii_in = "C";
        #10
        ascii_in = "B";
        #10
        ascii_in = "A";
        // Add stimulus here

        $finish();
    end
    
endmodule
    
