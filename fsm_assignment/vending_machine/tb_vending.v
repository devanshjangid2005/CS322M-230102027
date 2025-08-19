`timescale 1ns / 1ps

module tb_vending;
    reg clk, reset;
    reg [1:0] coin;
    wire dispense, chg5;

    vending_fsm uut (
        .clk(clk), .reset(reset), .coin(coin),
        .dispense(dispense), .chg5(chg5)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1; coin = 2'b00;
        #12 reset = 0;

        #10 coin = 2'b01;
        #10 coin = 2'b00;
        #10 coin = 2'b10;
        #10 coin = 2'b00;
        #10 coin = 2'b01;
        #10 coin = 2'b00;
        #10 coin = 2'b10;
        #10 coin = 2'b00;
        #10 coin = 2'b10;
        #10 coin = 2'b00;
        #10 coin = 2'b10;
        #10 coin = 2'b00;
        #10 coin = 2'b10;
        #10 coin = 2'b00;
        #10 coin = 2'b10;
        #10 coin = 2'b01;
        #10 coin = 2'b10;
        #10 coin = 2'b00;

        #50 $finish;
    end

    initial $monitor("t=%0t | coin=%b | dispense=%b | chg5=%b | state=%0d",
                     $time, coin, dispense, chg5, uut.state);

    initial begin
        $dumpfile("wave_vending.vcd");
        $dumpvars(1, tb_vending);
    end
endmodule
