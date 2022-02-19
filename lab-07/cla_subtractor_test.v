module cla_subtractor_test ();

    /* Make a reset that pulses once. */
    wire [3:0] diff;
    wire       cout;
    reg  [3:0] a   ;
    reg  [3:0] b   ;

    cla_subtractor  #(
        .NR_BITS(4)
    ) UUT (
        .diff (diff),
        .c_out(cout),
        .a    (a   ),
        .b    (b   )
    );

    initial begin
        $dumpfile("cla_subtractor_test.vcd");
        $dumpvars(0, cla_subtractor_test);

        a = 4;
        b = 3;

        #100;
        a = 1;
        b = 2;

        #100;
        $finish();

    end

    initial
        $monitor("At time %t, sum = %h (%0d), cout = %h (%0d)",
            $time, diff, diff, cout, cout);

endmodule