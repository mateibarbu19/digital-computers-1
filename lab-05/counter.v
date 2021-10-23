// `timescale 1ns / 1ps

module counter(
    input      [15:0] ascii_in, // 2 digits of ascii
    output reg [15:0] cnt,
    input             decrement,
    output reg        done,
    input             reset,
    input             clock
);

    always @(posedge clock) begin
        if (reset) begin
            cnt <= ascii_in;
        end else begin
            if (decrement && cnt != "UN") begin
                if (cnt == "01") begin
                    cnt     <= "UN";
                    done    <= 1;
                end else begin
                    if (cnt[7:0] == "0") begin
                        cnt[7:0]  <= "9";
                        cnt[15:8] <= cnt[15:8] - 1;
                    end else begin
                        cnt[7:0] <= cnt[7:0] - 1;
                    end
                    done <= 0;
                end
            end
        end
    end

endmodule