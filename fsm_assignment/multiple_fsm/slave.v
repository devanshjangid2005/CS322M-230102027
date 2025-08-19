`timescale 1ns / 1ps

module slave (
    input  wire clk,
    input  wire rst,
    input  wire req,
    input  wire [7:0] data_in,
    output wire ack,
    output reg  [7:0] last_byte
);

    parameter ST_WAIT    = 2'd0,
              ST_ASSERT  = 2'd1,
              ST_HOLD    = 2'd2,
              ST_DROP    = 2'd3;

    reg [1:0] state, next_state;
    reg [1:0] hold_cnt;

    always @(*) begin
        case (state)
            ST_WAIT:   next_state = req ? ST_ASSERT : ST_WAIT;
            ST_ASSERT: next_state = ST_HOLD;
            ST_HOLD:   next_state = (hold_cnt == 2'd1) ? ST_DROP : ST_HOLD;
            ST_DROP:   next_state = req ? ST_DROP : ST_WAIT;
            default:   next_state = ST_WAIT;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= ST_WAIT;
            hold_cnt  <= 2'd0;
            last_byte <= 8'd0;
        end 
        else begin
            state <= next_state;
            if (state == ST_ASSERT) begin
                last_byte <= data_in;  
                hold_cnt  <= 2'd0;
            end 
            else if (state == ST_HOLD) begin
                hold_cnt <= hold_cnt + 2'd1;
            end 
            else if (state == ST_WAIT) begin
                hold_cnt <= 2'd0;
            end
        end
    end

    assign ack = (state == ST_ASSERT) || (state == ST_HOLD) || (state == ST_DROP);

endmodule
