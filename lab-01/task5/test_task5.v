module test_task5;

    // Inputs.
    reg a;
    reg b;
    reg c_in;
    reg i;
    reg j;
    reg k;

    // Outputs.
    wire h_a_s;
    wire h_a_c_out;

    wire f_a_s;
    wire f_a_c_out;

    // Initializing Half-Adder.
    half_adder h_a (
        .a(a),
        .b(b),
        .s(h_a_s),
        .c_out(h_a_c_out)
    );

    full_adder f_a (
        .a(a),
        .b(b),
        .c_in(c_in),
        .s(f_a_s),
        .c_out(f_a_c_out)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_task5);
        // Initializing inputs.
        
        i = 1;
        repeat (2) begin
            i++;
            j = 1;
            repeat (2) begin
                j++;
                k = 1;
                repeat (2) begin
                    k++;

                    a = i;
                    b = j;
                    c_in = k;
                    #10;  // Wait 10s.
                end
            end
        end
	end
endmodule
