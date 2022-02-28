`ifndef INSTRUCTION

`define INSTRUCTION

/*
 * Description: Does NOTHING.
 * Operation: None.
 * Encoding: {NOP, x, x} (Note: "x" means that that any value can be used, the
 * instruction doesn't care, it doesn't use that value)
 */
`define INSTRUCTION_NOP 16'h0000

/*
 * Description: Performs a bitwise AND operation between the contents of
 * register Rd and Rr, and places the result in Rd.
 * Operation: Rd = Rd & Rr.
 * Encoding: {AND, d, r} (Note: "d" and "r" are two values which represent
 * register indexes. See the "registers" array in the cpu module)
 */
`define INSTRUCTION_AND 16'h0001

/*
 * Description: Performs a bitwise OR operation between the contents of
 * register Rd and Rr, and places the result in Rd.
 * Operation: Rd = Rd | Rr.
 * Encoding: {OR, d, r}
 */
`define INSTRUCTION_OR  16'h0002

/*
 * Description: Performs a bitwise XOR operation between the contents of
 * register Rd and Rr, and places the result in Rd.
 * Operation: Rd = Rd ^ Rr.
 * Encoding: {XOR, d, r}
 */
`define INSTRUCTION_XOR 16'h0003

/*
 * Description: Calculates the TWO'S COMPLEMENT value of the contents of
 * register Rd, and places the result in Rd.
 * Operation: Rd = -Rd.
 * Encoding: {NEG, d, x}
 */
`define INSTRUCTION_NEG 16'h0004

/*
 * Description: ADDS the contents of register Rd and Rr, and places the result
 * in Rd.
 * Operation: Rd = Rd + Rr.
 * Encoding: {ADD, d, r}
 */
`define INSTRUCTION_ADD 16'h0005

/*
 * Description: SUBTRACTS the contents of register Rr and from the contents of
 * register Rd, and places the result in Rd.
 * Operation: Rd = Rd - Rr.
 * Encoding: {SUB, d, r}
 */
`define INSTRUCTION_SUB 16'h0006

`endif
