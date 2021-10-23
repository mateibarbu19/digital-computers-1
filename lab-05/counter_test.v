module counter_test();
    
    // Inputs
    reg [15:0] contor;
    reg        reset;
    reg        clock;
    reg        decrement;
    
    // Outputs
    /* verilator lint_off UNUSED */
    wire [15:0] ascii_out;
    wire        done;
    /* verilator lint_on UNUSED */
    
    // Instantiate the Unit Under Test (UUT)
    counter uut (
        .ascii_in(contor),
        .cnt(ascii_out),
        .done(done),
        .reset(reset),
        .clock(clock),
        .decrement(decrement)
    );
    
    always
        #5 clock = ~clock;
    
    initial begin
        $dumpfile("waves_counter.vcd");
        $dumpvars(0, counter_test);
        
        clock     = 1;
        reset     = 1;
        contor    = "20";
        decrement = 1;
        #10;
        #1;
        reset = 0;
        #219;
        decrement = 0;
        $finish();
    end

endmodule
