module test_counter();

    reg reset;
    reg clk;
    wire [7:0] out_nb;
    wire [7:0] out_b;
    wire is_one_nb, is_one_b;

    counter uut(
        clk,
        reset,
        out_nb,
        out_b,
        is_one_nb,
        is_one_b
    );

    always
        #1 clk = ~clk;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_counter);
        reset = 1;
        clk = 0;
        #2;
        reset = 0;

        #34;

        $finish();
    end
endmodule
