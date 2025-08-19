`timescale 1ns / 1ps

module top (
    input  wire clk,
    input  wire rst,
    output wire done
);

    wire req, ack;
    wire [7:0] data;
    wire [7:0] last_byte;

    master u_master (
        .clk  (clk),
        .rst  (rst),
        .ack  (ack),
        .req  (req),
        .data (data),
        .done (done)
    );

    slave u_slave (
        .clk      (clk),
        .rst      (rst),
        .req      (req),
        .data_in  (data),
        .ack      (ack),
        .last_byte(last_byte)
    );

endmodule
