module ex4(
    output reg       mutant,
    output reg [2:0] currentState,
    input            A_debounced,
    input            G_debounced,
    input            C_debounced,
    input            T_debounced,
    input            reset,
    input            clk
);
    
    function [1:0] at_least_two_nucl;
        input A;
        input G;
        input C;
        input T;
        begin
            at_least_two_nucl =
                ~(~(A | G | C | T) |
                (A & ~(G | C | T)) |
                (G & ~(A | C | T)) |
                (C & ~(A | G | T)) |
                (T & ~(A | G | C)));
        end
    endfunction
    
    localparam STATE_0             = 0;
    localparam STATE_G             = 1;
    localparam STATE_GG            = 2;
    localparam STATE_GGT           = 3;
    localparam STATE_GGTC          = 4;
    localparam STATE_1_PlaceHolder = 5;
    localparam STATE_2_PlaceHolder = 6;
    localparam STATE_3_PlaceHolder = 7;
    
    reg not_ok; // is true if more than one nucleotide is given as input
    reg in; // is true if at least one nucleotide is given as input
    
    //Hint: we are going to declare some states that we never acces
    
    // Unlike the other FSM in this laboratory, this one has to identify a
    // pattern. This means that we have to track the progress (depth) made in
    // recognizing "GGTC".
    
    // Warning: The FSM must always be ready to receive input, be it correct or
    // not. This means that we have to be prepared to check the correctness of
    // the sequence making the right transitions, either by interrupting the
    // or going back a step in the checking process.
    
    always @(posedge clk) begin
        if (reset) begin
            currentState = STATE_0;
            mutant       = 0;
        end
        else begin
            not_ok = at_least_two_nucl(
                A_debounced,
                G_debounced,
                C_debounced,
                T_debounced
            );
            in = A_debounced | G_debounced | C_debounced | T_debounced;
            
            case (currentState)
                STATE_0: begin
                    mutant = 0;
                    if (G_debounced & ~not_ok) begin
                        currentState = STATE_G;
                    end
                end
                
                STATE_G: begin
                    mutant = 0;
                    if (G_debounced & ~not_ok) begin
                        currentState = STATE_GG;
                    end else if (in) begin
                        currentState = STATE_0;
                    end
                end
                    
                STATE_GG: begin
                    mutant = 0;
                    if (T_debounced & ~not_ok) begin
                        currentState = STATE_GGT;
                    end else if (G_debounced & ~not_ok) begin
                        currentState = STATE_GG;
                    end else if (in) begin
                        currentState = STATE_0;
                    end
                end
                            
                STATE_GGT: begin
                    mutant = 0;
                    if (C_debounced & ~not_ok) begin
                        // mutant    = 1;
                        currentState = STATE_GGTC;
                    end else if (G_debounced & ~not_ok) begin
                        currentState = STATE_G;
                    end else if (in) begin
                        currentState = STATE_0;
                    end
                end
                    
                STATE_GGTC: begin
                    mutant = 1;
                end
                                
                STATE_1_PlaceHolder : begin
                    currentState = STATE_0;
                end

                STATE_2_PlaceHolder : begin
                    currentState = STATE_0;
                end

                STATE_3_PlaceHolder : begin
                    currentState = STATE_0;
                end
            endcase
        end
    end
endmodule
