module adder_16_test ();

    /* Make a reset that pulses once. */
    wire [15:0] sum ;
    wire        cout;
    reg  [15:0] a   ;
    reg  [15:0] b   ;
    reg         c_in;

    adder_16 l_m_RC_CLA_0 (
        .sum  (sum ),
        .c_out(cout),
        .a    (a   ),
        .b    (b   ),
        .c_in (c_in)
    );

    initial begin
        $dumpfile("adder_16_test.vcd");
        $dumpvars(0, adder_16_test);

        a    = 4;
        b    = 3;
        c_in = 0;

        #100;
        c_in = 1;

        #100;
        a = 8;
        b = 7;


        #100;
        a = 1025;
        b = 255;


        #100;
        $finish();

    end

    initial
        $monitor("At time %t, sum = %h (%0d), cout = %h (%0d)",
            $time, sum, sum, cout, cout);

endmodule