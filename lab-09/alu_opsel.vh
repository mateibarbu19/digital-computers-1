`ifndef ALU_OPSEL

`define ALU_OPSEL

/*
 * Description: Does nothing.
 * Operation: None.
 */
`define OPSEL_NONE	3'h0

/*
 * Description: Performs a bitwise AND between A and B.
 * Operation: R = A & B.
 */
`define OPSEL_AND		3'h1

/*
 * Description: Performs a bitwise OR between A and B.
 * Operation: R = A | B.
 */
`define OPSEL_OR		3'h2

/*
 * Description: Performs a bitwise XOR between A and B.
 * Operation: R = A ^ B.
 */
`define OPSEL_XOR		3'h3

/*
 * Description: Calculates the TWO'S COMPLEMENT value of A.
 * Operation: R = ~A.
 */
`define OPSEL_NEG		3'h4

/*
 * Description: ADDS A and B.
 * Operation: R = A + B.
 */
`define OPSEL_ADD		3'h5

/*
 * Description: SUBTRACTS B from A.
 * Operation: R = A - B.
 */
`define OPSEL_SUB		3'h6

`endif
