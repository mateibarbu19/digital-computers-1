module rpc_adder_test ();

    /* Make a reset that pulses once. */
    wire [3:0] sum  ;
    wire       c_out;
    reg  [3:0] a    ;
    reg  [3:0] b    ;
    reg        c_in ;

    rpc_adder UUT (
        .sum  (sum  ),
        .c_out(c_out),
        .a    (a    ),
        .b    (b    ),
        .c_in (c_in )
    );

    initial begin
        $dumpfile("rpc_adder_test.vcd");
        $dumpvars(0, rpc_adder_test);

        a    = 4;
        b    = 3;
        c_in = 0;

        #100;
        c_in = 1;

        #100;
        a = 8;
        b = 7;

        #100;
        $finish();

    end

    initial
        $monitor("At time %t, sum = %h (%0d), c_out = %h (%0d)",
            $time, sum, sum, c_out, c_out);

endmodule