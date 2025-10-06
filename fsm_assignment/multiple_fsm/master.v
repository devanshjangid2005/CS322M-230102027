`timescale 1ns / 1ps

module master (
    input  wire clk,
    input  wire rst,
    input  wire ack,
    output wire req,
    output wire done,
    output wire [7:0] data
);

    reg [2:0] state, next_state;
    reg [2:0] bytes_sent;  
    reg [7:0] data_reg;

    parameter ST_IDLE    = 3'd0,
              ST_REQ     = 3'd1,
              ST_WAIT_HI = 3'd2,
              ST_DROP    = 3'd3,
              ST_WAIT_LO = 3'd4,
              ST_NEXT    = 3'd5,
              ST_DONE    = 3'd6;

    always @(*) begin
        case (state)
            ST_IDLE:    next_state = ST_REQ;
            ST_REQ:     next_state = ST_WAIT_HI;
            ST_WAIT_HI: next_state = ack ? ST_DROP : ST_WAIT_HI;
            ST_DROP:    next_state = ST_WAIT_LO;
            ST_WAIT_LO: next_state = !ack ? ST_NEXT : ST_WAIT_LO;
            ST_NEXT:    next_state = (bytes_sent == 3'd4) ? ST_DONE : ST_REQ;
            ST_DONE:    next_state = ST_DONE;
            default:    next_state = ST_IDLE;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state      <= ST_IDLE;
            bytes_sent <= 3'd0;
            data_reg   <= 8'hA0;
        end 
        else begin
            state <= next_state;
            if (state == ST_WAIT_LO && ack == 1'b0) begin
                bytes_sent <= bytes_sent + 3'd1;
                data_reg   <= data_reg + 8'h01;
            end
        end
    end

    assign req  = (state == ST_REQ) || (state == ST_WAIT_HI);
    assign done = (state == ST_DONE);
    assign data = data_reg;

endmodule
