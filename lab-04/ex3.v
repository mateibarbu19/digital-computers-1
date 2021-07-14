// `timescale 1ns / 1ps
`include "lib/defines.vh"

module ex3(
    output reg [7:0] out,
    input            button_debounced,
    input            reset,
    input            clk
);
    
    localparam STATE_INITIAL     = 0;
    localparam STATE_T00         = 1;
    localparam STATE_T01         = 2;
    localparam STATE_PLACEHOLDER = 3;
    
    reg button_pressed;
    
    // the counters mark the passage of time
    reg [31:0]  red_counter;
    reg [31:0]  green_counter;
    reg [1:0]   currentState;
    reg [1:0]   nextState;
    
    initial begin
        red_counter    = 0;
        green_counter  = 0;
        currentState   = STATE_INITIAL;
        button_pressed = 0;
    end
    
    // The output is a series of 8 LEDs which we should control.
    
    // This always block implements both the output and transition logic.
    always @(posedge clk) begin
        if (reset) begin
            red_counter    = 0;
            green_counter  = 0;
            currentState   = STATE_INITIAL;
            button_pressed = 0;
            end else begin
            case (currentState)
                STATE_INITIAL: begin
                    out       = 8'b00000000;
                    nextState = STATE_T00;
                end
                
                STATE_T00: begin
                    // Turn on the first 4 LEDs
                    out = 8'b11110000;
                    
                    // If the debounced button is pressed, it's first press
                    // should start the internal countdown state.
                    if (button_debounced) begin
                        if (!button_pressed) begin
                            button_pressed = 1;
                            red_counter    = 0;
                        end
                        end else if (!button_pressed) begin
                            red_counter = 0;
                        end
                        
                        nextState = STATE_T00;
                        if (button_pressed) begin
                            red_counter = red_counter + `SECOND;
                            if (red_counter == `SMPHR_RED_TMR) begin
                                nextState     = STATE_T01;
                                red_counter   = 0;
                                green_counter = 0;
                            end
                        end
                    end
                    
                    STATE_T01: begin
                        out = 8'b00001111;
                        
                        button_pressed = 0;
                        
                        nextState     = STATE_T01;
                        green_counter = green_counter + `SECOND;
                        if (green_counter == `SMPHR_GRN_TMR) begin
                            nextState     = STATE_T00;
                            green_counter = 0;
                            red_counter   = 0;
                        end
                    end
                    
                    STATE_PLACEHOLDER: begin
                        // ERROR
                        // The execution flow show not reach this point
                        out       = 8'b00000000;
                        nextState = STATE_INITIAL;
                    end
                    
            endcase
        end
        currentState = nextState;
    end
endmodule
