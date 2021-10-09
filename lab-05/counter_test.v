// `timescale 1ns / 1ps

module counter_test();
    
    // Inputs
    reg [15:0] contor;
    reg        reset;
    reg        clock;
    reg        decrement;
    
    // Outputs
    wire [15:0] ascii_out;
    wire        done;
    
    // Instantiate the Unit Under Test (UUT)
    counter uut (
        .ascii_in(contor),
        .cnt(ascii_out),
        .done(done),
        .reset(reset),
        .clock(clock),
        .decrement(decrement)
    );
    
    always@(clock)
        #5 clock <= ~clock;
    
    initial begin
        $dumpfile("waves_counter.vcd");
        $dumpvars(0, counter_test);
        
        clock     = 1;
        reset     = 1;
        contor    = "20";
        decrement = 1;
        #1;
        #10;
        reset = 0;
        #10;
        $finish();
    end

endmodule
