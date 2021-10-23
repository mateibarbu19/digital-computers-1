/* verilator lint_off WIDTH */
`timescale 1ns / 1ps

module ordinator_8bit (
    output reg [7:0] result,
    output reg		 ready,
    input      [7:0] in,
    input            reset,
    input            clk
);

    localparam OPERATOR_ADD = 2'd0,
               OPERATOR_SUB = 2'd1,
               OPERATOR_EQL = 2'd2,
               OPERATOR_ERR = 2'd3;

    localparam STATE_INITIAL = 3'd0;
    localparam STATE_NUMBER  = 3'd1;
    localparam STATE_WAIT_NR = 3'd2;
    localparam STATE_RESULT  = 3'd3;
    localparam STATE_DUMMY1  = 3'd4;
    localparam STATE_DUMMY2  = 3'd5;
    localparam STATE_DUMMY3  = 3'd6;

    reg [2:0] currentState;
    reg [2:0] nextState;
    reg [7:0] tmp_result;
    reg [7:0] last_tmp_result;

    /* verilator lint_off UNOPTFLAT */
    reg        operation;
    /* verilator lint_on UNOPTFLAT */
    /* verilator lint_off UNUSED */
    wire       add_carry;
    wire       sub_carry;
    /* verilator lint_on UNUSED */
    wire [7:0] diff;
    wire [7:0] sum;

    ripple_carry_8bit adder (
        .carry_out(add_carry),
        .sum(sum),
        .A(last_tmp_result),
        .B(in),
        .carry_in(1'b0)
    );
    subtractor_8bit subtr (
        .carry_out(sub_carry),
        .result(diff),
        .A(last_tmp_result),
        .B(in),
        .carry_in(1'b0)
    );

    always @(posedge clk) begin
        last_tmp_result <= tmp_result;

        if (reset) begin
            ready        <= 1;
            result       <= 0;
            tmp_result   <= 0;
            nextState    <= STATE_INITIAL;
            currentState <= STATE_INITIAL;
        end else begin
            case (currentState)
                STATE_INITIAL: begin
                    ready <= 0;
                    if (in > 3) begin
                        nextState  <= STATE_DUMMY1;
                        tmp_result <= in;
                    end
                end

                STATE_DUMMY1: begin
                    ready     <= 1;
                    nextState <= STATE_NUMBER;
                end

                STATE_NUMBER: begin
                    ready <= 0;
                    if (in == 3) begin
                        nextState  <= STATE_RESULT;
                        tmp_result <= 0;
                    end else if (in == 2) begin
                        nextState <= STATE_RESULT;
                    end else if (in < 2) begin
                        operation <= in[0];
                        nextState <= STATE_DUMMY2;
                    end else if (in > 3) begin
                        ready <= 1;
                    end
                end

                STATE_DUMMY2: begin
                    ready     <= 1;
                    nextState <= STATE_WAIT_NR;
                end

                STATE_WAIT_NR: begin
                    if (in == 3) begin
                        ready      <= 0;
                        nextState  <= STATE_RESULT;
                        tmp_result <= 0;
                    end else if (in > 3) begin
                        ready <= 0;
                        case (operation)
                            0: tmp_result <= sum; // tmp_result + in;
                            1: tmp_result <= diff; //tmp_result - in;
                        endcase
                        nextState <= STATE_DUMMY3;
                    end
                end

                STATE_DUMMY3: begin
                    ready     <= 1;
                    nextState <= STATE_NUMBER;
                end

                STATE_RESULT: begin
                    ready     <= 1;
                    result    <= tmp_result;
                    nextState <= STATE_INITIAL;
                end

                // This default case is important! The currentState may be 2b'xx.
                default: begin
                    ready     <= 1;
                    nextState <= STATE_INITIAL;
                end
            endcase
        end
        currentState <= nextState;
    end

endmodule
