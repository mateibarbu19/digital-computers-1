// `timescale 1ns / 1ps

module counter(
    input      [15:0] ascii_in, // 2 digits of ascii
    output reg [15:0] counter,
    input             decrement,
    output reg        done,
    input             reset,
    input             clock
);

    always @(posedge clock) begin
        if (reset) begin
            counter <= ascii_in;
        end else begin
            if (decrement) begin
                if (counter == "UN") begin
                    done = 1;
                end else begin
                    if (counter == "01") begin
                        counter = "UN";
                        done    = 1;
                    end else begin
                        if (counter[7:0] == "0") begin
                            counter[7:0] = "9";
                            counter[15:8] = counter[15:8] - 1;
                        end else begin
                            counter[7:0] = counter[7:0] - 1;
                        end
                        done = 0;
                    end
                end
            end
        end
    end

endmodule