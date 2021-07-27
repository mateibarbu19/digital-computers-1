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

    localparam STATE_INITIAL = 3'd0;
    localparam STATE_NUMBER  = 3'd1;
    localparam STATE_WAIT_NR = 3'd2;
    localparam STATE_RESULT  = 3'd3;

    reg [2:0] currentState;
    reg [2:0] nextState;
    reg [7:0] tmp_result;
    reg [7:0] tmp_result2;

    always @(*) begin
        if (reset) begin
            ready      <= 0;
            result     <= 0;
            tmp_result <= 0;
        end else begin
            if (currentState == STATE_RESULT) begin
                result = tmp_result;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            currentState = STATE_INITIAL;
        end else begin
            currentState = nextState;
        end
        ready       = 1;
        tmp_result2 = tmp_result;
    end

    reg        operation;
    wire       add_carry;
    wire       sub_carry;
    wire [7:0] diff;
    wire [7:0] sum;

    ripple_carry_8bit adder (
        .carry_out(add_carry),
        .sum(sum),
        .A(tmp_result2),
        .B(in),
        .carry_in(1'b0)
    );
    subtractor_8bit subtr (
        .carry_out(sub_carry),
        .result(diff),
        .A(tmp_result2),
        .B(in),
        .carry_in(1'b0)
    );

    always @(*) begin
        case (currentState)
            STATE_INITIAL: begin
                ready <= 0;
                if (in > 3) begin
                    nextState  <= STATE_NUMBER;
                    tmp_result <= in;
                end
            end

            STATE_NUMBER: begin
                ready <= 0;
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

            STATE_WAIT_NR: begin
                ready <= 0;
                if (in == 3) begin
                    nextState <= STATE_INITIAL;
                end else if (in > 3) begin
                    // @(posedge clk);
                    case (operation)
                        0: tmp_result = sum; // tmp_result + in;
                        1: tmp_result = diff; //tmp_result - in;
                    endcase
                    nextState = STATE_NUMBER;
                end
            end

            STATE_RESULT: begin
                ready     <= 0;
                nextState <= STATE_INITIAL;
            end

            default: begin
                ready     <= 0;
                nextState <= STATE_INITIAL;
            end
        endcase
    end
endmodule
