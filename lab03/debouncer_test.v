`timescale 1ns / 1ps

module debouncer_test;
    wire out;
    reg in;
    reg clk;
    reg reset;

    debouncer uut(
        .button_out(out),
        .button_in(in),
        .clock(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waves_debouncer.vcd");
        $dumpvars(0, debouncer_test);

        in = 0;
        clk = 0;
        reset = 1;
        #10

        reset = 0;
        in = 1;
        #1
        in = 0;
        #1
        in = 1;
        #1
        in = 0;
        #1
        in = 1;

        #100

        #1
        in = 0;
        #1
        in = 1;
        #1
        in = 0;
        #1
        in = 1;
        #1
        in = 0;
        #20

        $finish();
    end
    
endmodule