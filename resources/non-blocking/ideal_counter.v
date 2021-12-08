module ideal_counter (
    input        clk,
    input        reset,
    output [7:0] out
);

    reg [7:0] buff_out;

    always @(posedge clk) begin
        if (reset) begin
            buff_out <= 0;
        end else begin
            buff_out <= buff_out + 8'd1;
        end
    end

    assign out = buff_out;
endmodule
