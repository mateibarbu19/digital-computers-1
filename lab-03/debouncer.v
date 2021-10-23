`timescale 1ns / 1ps

module debouncer(
    output reg button_out,
    input      button_in,
    input      clock,
    input      reset
);

    reg [2:0] nr_times;
    reg old_in;

    always @(posedge clock) begin
        if (reset) begin
            nr_times   <= 0;
            button_out <= 0;
            old_in     <= 0;
        end else begin
            if (button_in == old_in) begin
                if (nr_times == 0) begin
                    button_out <= button_in;
                end else begin
                    nr_times <= nr_times + 1;
                end
            end else begin
                nr_times <= 0;
            end
            old_in <= button_in;
        end
    end

endmodule
