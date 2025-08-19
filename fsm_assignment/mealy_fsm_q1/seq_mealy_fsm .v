`timescale 1ns / 1ps

module seq_mealy_fsm (
    input  wire clk,
    input  wire din,
    input  wire reset,
    output reg  y
);

    parameter A = 2'd0, 
              B = 2'd1, 
              C = 2'd2, 
              D = 2'd3;

    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = din ? B : A; 
            B: next_state = din ? C : A; 
            C: next_state = din ? C : D; 
            D: next_state = din ? B : A; 
            default: next_state = A; 
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        y = (state == D) & din; 
    end

endmodule
