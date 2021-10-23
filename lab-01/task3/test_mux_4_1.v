module test_mux_4_1();

    // Inputs.
    reg a;
    reg b;
    reg c;
    reg d;
    reg [1:0] sel;
    reg i;
    reg j;
    reg k;
    reg l;
    /* verilator lint_off UNUSED */
    reg out;
    wire res;
    /* verilator lint_on UNUSED */

    // Initializing UUT.
    mux_4_1 UUT (
        .out(res),
        .in0(a),
        .in1(b),
        .in2(c),
        .in3(d),
        .sel0(sel[0]),
        .sel1(sel[1])
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test_mux_4_1);
        // Initializing inputs.
        
        sel = 0;
        repeat (4) begin
            i = 0;
            repeat (2) begin
                j = 0;
                repeat (2) begin
                    k = 0;
                    repeat (2) begin
                        l = 0;
                        repeat (2) begin
                            a = i;
                            b = j;
                            c = k;
                            d = l;

                            #10; // Wait 10s.
                            l++;
                        end
                        k++;
                    end
                    j++;
                end
                i++;
            end
            sel++;
        end
	end
endmodule
