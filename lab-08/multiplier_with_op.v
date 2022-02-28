`include "defines.vh"
module multiplier_with_op #(
    parameter NR_BITS = 4
) (
    output [2*NR_BITS-1:0] out,
    input  [  NR_BITS-1:0] M  ,
    input  [  NR_BITS-1:0] R
);
    //  Implement Booth's algorithm

    wire [2*NR_BITS:0] A = {M, {NR_BITS+1{1'b0}}};

    reg [2*NR_BITS:0] P;

    always @(*) begin
        P = {{NR_BITS{1'b0}}, R, 1'b0};
        repeat(NR_BITS) begin
            case (P[1:0])
                2'b01   : P = P + A;
                2'b10   : P = P - A;
                default : ;
            endcase
            P = $signed(P) >>> 1;
        end
    end

    // DONE: assign in out the product of M and R
    assign out = P[2*NR_BITS:1];

endmodule
