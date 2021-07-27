`timescale 1ns / 1ps

module ordinator_8bit (
    output reg [7:0] result,
    output reg		 ready,
    input      [7:0] in,
    input            reset,
    input            clk
);

    localparam FALSE = 2'd0,
               TRUE  = 2'd1;

    localparam OPERATOR_ADD = 2'd0,
               OPERATOR_SUB = 2'd1,
               OPERATOR_EQL = 2'd2,
               OPERATOR_ERR = 2'd3;

// ----------------------------------------------------------------------------
// TODO 4.1: Codificati starile necesare automatului.
// HINT: Pentru a va fi mai usor, porniti de la implementarea de mai jos.
// ----------------------------------------------------------------------------

    localparam STATE_INITIAL = 3'd0;
    localparam STATE_NUMBER  = 3'd1;
    localparam STATE_WAIT_NR = 3'd2;
    localparam STATE_RESULT  = 3'd3;

// ----------------------------------------------------------------------------
// Folositi registrii de mai jos pentru a memora starile
// ----------------------------------------------------------------------------
    reg [2:0] currentState;
    reg [2:0] nextState;
 
// ----------------------------------------------------------------------------
// TODO 4.2: Definiti comportamentul iesirilor
// HINT: Verificati care este rezultatul final in functie de starea curenta
// ----------------------------------------------------------------------------

    reg [7:0] tmp_result;

    always @(*) begin
        if (reset) begin
            ready  <= 0;
            result <= 0;
        end else begin
            ready = 1;
            // case (currentState)
            //     STATE_INITIAL,
            //     STATE_NUMBER,
            //     STATE_WAIT_NR,
            //     STATE_RESULT:
            //         resu = 1;
            //     default:
                    
            // endcase
            if (currentState == STATE_RESULT) begin
                result = tmp_result;
            end
        end
    end
 
// ----------------------------------------------------------------------------
// TODO 4.3: Definiti mecanismul de tranzitie a starilor
// HINT: Folositi currentState si nextState
// ----------------------------------------------------------------------------

    always @(*) begin
        if (reset) begin
            currentState = STATE_INITIAL;
        end else begin
            currentState = nextState;
        end
    end

// ----------------------------------------------------------------------------
// Definiti comportamentul si modul de schimbare a starilor urmand TODO-urile
// de mai jos
// ----------------------------------------------------------------------------



// ----------------------------------------------------------------------------
// TODO 4.4: Declarati-va variabilele locale de care aveti nevoie in
// implementare
// ----------------------------------------------------------------------------

    reg operation;




// ----------------------------------------------------------------------------
// TODO 4.5: Declarati-va modulele implementate anterior de care aveti nevoie
// in implementare.
// ----------------------------------------------------------------------------



    always @(*) begin
        case (currentState)
            // -------------------------------------------------------------------
            // TODO 4.6: Implementati modulul de schimbare a starilor
            // -------------------------------------------------------------------
            STATE_INITIAL: begin
                if (in > 3) begin
                    nextState  <= STATE_NUMBER;
                    tmp_result <= in;
                end
            end

            STATE_NUMBER: begin
                if (in == 3) begin
                    nextState  <= STATE_INITIAL;
                    tmp_result <= 0;
                end else if (in == 2) begin
                    nextState <= STATE_RESULT;
                end else if (in < 2) begin
                    operation <= in[0];
                    nextState <= STATE_WAIT_NR;
                end
            end

            STATE_WAIT_NR:
                if (in == 3) begin
                    nextState <= STATE_INITIAL;
                end else if (in > 3) begin
                    case (operation)
                        0: tmp_result = tmp_result + in;
                        1: tmp_result = tmp_result - in;
                    endcase
                    nextState <= STATE_NUMBER;
                end
            
            STATE_RESULT:
                nextState <= STATE_INITIAL;

            default:
                nextState <= STATE_INITIAL;
        endcase
    end
endmodule
