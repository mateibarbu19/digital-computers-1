/* verilator lint_off WIDTH */
// `timescale 1ns / 1ps
`include "lib/defines.vh"

module ex2(
    output reg [7:0] out,
    output reg [3:0] currentState,
    input            reset,
    input            clk
);

    localparam STATE_INITIAL = 0;
    localparam STATE_T00     = 1;
    localparam STATE_T01     = 2;
    localparam STATE_T02     = 3;
    localparam STATE_T03     = 4;
    localparam STATE_T04     = 5;
    localparam STATE_T05     = 6;
    localparam STATE_T06     = 7;
    localparam STATE_T07     = 8;
    localparam STATE_T08     = 9;
    localparam STATE_T09     = 10;
    localparam STATE_T10     = 11;
    localparam STATE_T11     = 12;
    localparam STATE_T12     = 13;
    localparam STATE_T13     = 14;
    localparam STATE_T14     = 15;
    
    // use count to delay the state transitions with one second
    reg [31:0]  count;
    reg [3:0] nextState;
    
    // Time based action
    always @(posedge clk) begin
        if (reset) begin
            count        <= 0;
            currentState <= STATE_INITIAL;
        end
        else begin
            count        <= count + `SECOND;
            currentState <= nextState;
        end
    end
    
    // The output for each state should look like:
    //t00 *-*-*-*-
    //t01 -*-*-*-*
    //t02 *-*-*-*-
    //t03 -*-*-*-*
    //t04 *------*
    //t05 -*----*-
    //t06 --*--*--
    //t07 ---**---
    //t08 --*--*--
    //t09 -*----*-
    //t10 *------*
    //t11 -**-*--*
    //t12 *---**-*
    //t13 *---*-**
    //t14 -**-*--*
    //mergi la t00
    
    
    //Legend:	"*" = "LED on" = "1" in code
    //			"-" = "LED off" = "0" in code
    
    // State based action
    always @(*) begin
        case (currentState)
            // Set the output for each state and the next transition
            STATE_INITIAL: begin
                nextState = STATE_T00;
                out       = 8'b00000000;
            end
            STATE_T00: begin
                nextState = STATE_T01;
                out       = 8'b10101010;
            end
            STATE_T01: begin
                nextState = STATE_T02;
                out       = 8'b01010101;
            end
            STATE_T02: begin
                nextState = STATE_T03;
                out       = 8'b10101010;
            end
            STATE_T03: begin
                nextState = STATE_T04;
                out       = 8'b01010101;
            end
            STATE_T04: begin
                nextState = STATE_T05;
                out       = 8'b10000001;
            end
            STATE_T05: begin
                nextState = STATE_T06;
                out       = 8'b01000010;
            end
            STATE_T06: begin
                nextState = STATE_T07;
                out       = 8'b00100100;
            end
            STATE_T07: begin
                nextState = STATE_T08;
                out       = 8'b00011000;
            end
            STATE_T08: begin
                nextState = STATE_T09;
                out       = 8'b00100100;
            end
            STATE_T09: begin
                nextState = STATE_T10;
                out       = 8'b01000010;
            end
            STATE_T10: begin
                nextState = STATE_T11;
                out       = 8'b10000001;
            end
            STATE_T11: begin
                nextState = STATE_T12;
                out       = 8'b01101001;
            end
            STATE_T12: begin
                nextState = STATE_T13;
                out       = 8'b10001101;
            end
            STATE_T13: begin
                nextState = STATE_T14;
                out       = 8'b10001011;
            end
            STATE_T14: begin
                nextState = STATE_T00;
                out       = 8'b01101001;
            end
        endcase
    end
endmodule
