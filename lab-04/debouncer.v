module debouncer(
    output reg button_out,
    input      clk,
    input      reset,
    input      button_in
);

    reg [1:0] count;
    reg button_tmp;
     
     initial begin
        count <= 0;
     end

    always @(posedge clk) begin
        if (reset == 1) begin
            count <= 0;
            button_tmp <= 0;
            button_out <= 0;
        end else begin
            count <= count + 1;
            button_tmp <= button_in;

            if (count == 0) begin
                button_out <= button_tmp;
            end
        end
    end
endmodule
