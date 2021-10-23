/* verilator lint_off WIDTH */
//`timescale 1ns / 1ps
`include "lib/defines.vh"

module ex1(
    output reg out,
    input      reset,
    input      clk
);

    localparam STATE_OFF = 0;
    localparam STATE_ON = 1;

    // use the "count" register to keep track of time passed from the last
    // transition
    reg        currentState;
    reg [31:0] count;

    always @(posedge clk) begin
        // What happens if the user presses reset?

        if (reset == 1) begin
            currentState <= STATE_OFF;
            count        <= 0;
        end else begin
            if (count == `LED_TMR) begin
                count        <= 0;
                currentState <= 1 - currentState;
            end else begin
                count <= count + 1;
            end
        end
    end

    always @(*) begin
        case (currentState)
            // For each state set the corresponding output (Moore FSM)

            STATE_OFF: out = 0;
            STATE_ON:  out = 1;
            default:   out = 1'bx;
        endcase
    end
endmodule
