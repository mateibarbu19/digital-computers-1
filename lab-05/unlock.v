// `timescale 1ns / 1ps
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
    
    reg [3:0]   state;
    reg [3:0]   next_state;
    reg [7:0]   read;
    reg         decrement;
    reg [1:0]   fail;
    reg [15:0]  timer;
    reg         timer_reset;
    reg [7:0]   password [0:3];
    wire [15:0] time_counter;
    wire        done;
    
    
    always @(posedge clk) begin
        if (reset) begin
            state       = STATE_INIT;
            fail        = 2'b00;
            timer_reset = 0;
            decrement   = 0;
            password[0] = "A";
            password[1] = "C";
            password[2] = "B";
            password[3] = "D";
        end else begin
            state = next_state;

            if (state == STATE_COUNTER) begin
                if (!decrement) begin
                    fail        <= 0;
                    timer       <= "03";
                    decrement   <= 1;

                    timer_reset <= 1;
                    @(posedge clk);
                    timer_reset <= 0;
                end else if (done) begin
                    decrement  = 0;
                    state      = STATE_INIT;
                    next_state = STATE_INIT;

                    @(posedge clk);
                end
            end
        end
    end
    
    always @(*) begin
        if (!reset) begin
            read = ascii_in;
        end
    end
    
    always @(ascii_in) begin
        next_state = state;
        
        case (state)
            STATE_INIT: begin
                $display("%c%c%c%c", password[0], password[1], password[2], password[3]);
                if (read == password[0]) begin
                    next_state = STATE_1;
                end else begin
                    fail++;
                    next_state = STATE_INIT;
                end
            end

            STATE_1: begin
                if (read == password[1]) begin
                    next_state = STATE_2;
                end else if (read == password[0]) begin
                    fail++;
                    next_state = STATE_1;
                end else begin
                    fail++;
                    next_state = STATE_INIT;
                end
            end

            STATE_2: begin
                if (read == password[2]) begin
                    next_state = STATE_3;
                end else if (read == password[0]) begin
                    fail++;
                    next_state = STATE_1;
                end else begin
                    fail++;
                    next_state = STATE_INIT;
                end
            end

            STATE_3: begin
                if (read == password[3]) begin
                    next_state = STATE_UNLOCK;
                end else if (read == password[0]) begin
                    fail++;
                    next_state = STATE_1;
                end else begin
                    fail++;
                    next_state = STATE_INIT;
                end
            end

            STATE_COUNTER: begin
                // In this state, the lock does not interpret any input
                // introduced, for a while. It does so by setting a counter
                // which is decremented at every positive edge of the clock.
                // Taking into account the overhead of first resting the
                // counter, and then the after time to wait, the total waiting
                // period is 5 clock cycles.
            end

            STATE_UNLOCK: begin
                fail        = 0;
                next_state  = STATE_UNLOCK_1;
                password[0] = read;
            end

            STATE_UNLOCK_1: begin
                next_state  = STATE_UNLOCK_2;
                password[1] = read;
            end

            STATE_UNLOCK_2: begin
                next_state  = STATE_UNLOCK_3;
                password[2] = read;
            end

            STATE_UNLOCK_3: begin
                next_state  = STATE_INIT;
                password[3] = read;
            end

            default: begin
                next_state = STATE_INIT;
            end
        endcase

        if (fail == 3) begin
            next_state = STATE_COUNTER;
            // If the number of incorrect inputs has reached 3, wait for the
            // next positive clock edge and discard any input in the meanwhile
            // to make sure that the transition is made successfully.
            @(posedge clk);
        end
    end
    
    assign out = (state == STATE_UNLOCK ? 1 : 0);

    counter counter1(
        .ascii_in(timer),
        .counter(time_counter),
        .decrement(decrement),
        .done(done),
        .reset(timer_reset),
        .clock(clk)
    );

endmodule
