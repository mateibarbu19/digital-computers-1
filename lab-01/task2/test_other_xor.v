module test_other_xor();

    // Inputs.
    reg a;
    reg b;
    wire res;

    // Initializing UUT.
    other_xor UUT (
        .out(res),
        .in0(a),
        .in1(b)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_other_xor);
        // Initializing inputs.
        
        a = 0;
        repeat (2) begin
            b = 0;
            repeat (2) begin
                #10 // Wait 10s.
                b++;
            end
            a++;
        end
	end
endmodule
