module counter (
    input        clk,
    input        reset,
    output [7:0] out_nb,
    output [7:0] out_b,
    output       is_one_nb,
    output       is_one_b
);
    
    reg [7:0] buff_out_nb;
    reg [7:0] buff_out_b;
    reg       buff_is_one_nb;
    reg       buff_is_one_b;

    always @(posedge clk) begin
        if (reset) begin
            buff_out_nb    <= 0;
            buff_out_b     <= 0;
            buff_is_one_nb <= 0;
            buff_is_one_b  <= 0;
        end else begin
            buff_out_nb <= buff_out_nb + 8'd1;
            buff_out_b = buff_out_b + 8'd1;
        end
        if (buff_out_nb == 8'd1) begin
            buff_is_one_nb <= 8'd1;
        end
        if (buff_out_b == 8'd1) begin
            buff_is_one_b <= 8'd1;
        end
        $display("Active:   NB-OUT: %d, B-OUT: %d %t", out_nb, out_b, $time);
        $strobe("Postpone: NB-OUT: %d, B-OUT: %d %t", out_nb, out_b, $time);
        $strobe("------------------------------------------------------");
    end

    assign out_nb    = buff_out_nb;
    assign out_b     = buff_out_b;
    assign is_one_nb = buff_is_one_nb;
    assign is_one_b  = buff_is_one_b;

endmodule
