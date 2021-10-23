module unlock(
    input [7:0] ascii_in, // one digit ascii
    output      out,
    input       reset,
    input       clk
);
    
    parameter STATE_INIT     = 4'b0000,
              STATE_1        = 4'b0001,
              STATE_2        = 4'b0010,
              STATE_3        = 4'b0011,
              STATE_COUNTER  = 4'b0110,
              STATE_UNLOCK   = 4'b0111,
              STATE_UNLOCK_1 = 4'b1000,
              STATE_UNLOCK_2 = 4'b1001,
              STATE_UNLOCK_3 = 4'b1010;
    
    reg  [3:0]  state;
    reg         decrement;
    reg  [1:0]  fail;
    reg  [15:0] timer;
    reg         timer_reset;
    reg  [7:0]  password [0:3];
    wire        done;
    /* verilator lint_off UNUSED */
    wire [15:0] time_counter;
    /* verilator lint_on UNUSED */
    
    
    always @(posedge clk) begin
        if (reset) begin
            state       <= STATE_INIT;
            fail        <= 2'b00;
            timer_reset <= 0;
            decrement   <= 0;
            password[0] <= "A";
            password[1] <= "C";
            password[2] <= "B";
            password[3] <= "D";
        end else begin
            case (state)
                STATE_INIT: begin
                    if (ascii_in == password[0]) begin
                        state <= STATE_1;
                    end else begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_INIT;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end
                end

                STATE_1: begin
                    if (ascii_in == password[1]) begin
                        state <= STATE_2;
                    end else if (ascii_in == password[0]) begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_1;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end else begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_INIT;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end
                end

                STATE_2: begin
                    if (ascii_in == password[2]) begin
                        state <= STATE_3;
                    end else if (ascii_in == password[0]) begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_1;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end else begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_INIT;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end
                end

                STATE_3: begin
                    if (ascii_in == password[3]) begin
                        state <= STATE_UNLOCK;
                    end else if (ascii_in == password[0]) begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_1;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end else begin
                        fail <= fail + 1;
                        if (fail != 2) begin
                            state <= STATE_INIT;
                        end else begin
                            state <= STATE_COUNTER;
                        end
                    end
                end

                STATE_COUNTER: begin
                    // In this state, the lock does not interpret any input
                    // introduced, for a while. It does so by setting a counter
                    // which is decremented at every positive edge of the clock.
                    // Taking into account the overhead of first resting the
                    // counter, and then the after time to wait, the total waiting
                    // period is 6 clock cycles.
                    if (fail == 3) begin
                        fail        <= 0;
                        timer       <= "02";
                        decrement   <= 1;
                        timer_reset <= 1;
                    end else begin
                        timer_reset <= 0;
                        if (done) begin
                            decrement  <= 0;
                            state      <= STATE_INIT;
                        end
                    end
                end

                STATE_UNLOCK: begin
                    fail        <= 0;
                    state  <= STATE_UNLOCK_1;
                    password[0] <= ascii_in;
                end

                STATE_UNLOCK_1: begin
                    state  <= STATE_UNLOCK_2;
                    password[1] <= ascii_in;
                end

                STATE_UNLOCK_2: begin
                    state  <= STATE_UNLOCK_3;
                    password[2] <= ascii_in;
                end

                STATE_UNLOCK_3: begin
                    state  <= STATE_INIT;
                    password[3] <= ascii_in;
                end

                default: begin
                    state <= STATE_INIT;
                end
            endcase
        end
    end
    
    assign out = (state == STATE_UNLOCK ? 1 : 0);

    counter counter1(
        .ascii_in(timer),
        .cnt(time_counter),
        .decrement(decrement),
        .done(done),
        .reset(timer_reset),
        .clock(clk)
    );

endmodule
