`timescale 1ns / 1ps

module tb_handshake;

    reg clk, rst;
    wire done;

    top uut (
        .clk (clk),
        .rst (rst),
        .done(done)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        #12 rst = 1'b0;
    end

    initial begin
        $dumpfile("wave_final.vcd");
        $dumpvars(1, tb_handshake);
        $monitor("T=%0t | req=%b ack=%b data=%h last_byte=%h done=%b",
                 $time, uut.u_master.req, uut.u_slave.ack, 
                 uut.u_master.data, uut.u_slave.last_byte, done);
        #1000 $finish;
    end

endmodule
