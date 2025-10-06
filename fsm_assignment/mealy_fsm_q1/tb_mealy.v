`timescale 1ns / 1ps

module tb_mealy;
    reg clk, din, reset;
    wire y;

    seq_mealy_fsm uut (.clk(clk), .din(din), .reset(reset), .y(y));

    always #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("wave_mealy.vcd");   
        $dumpvars(1, tb_mealy);  
    end

    initial begin
        clk = 0; din = 0; reset = 1;
        #20 reset = 0; 

        for (i=0; i<4; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 1;
                2: din = 0;
                3: din = 1;
            endcase
            @(posedge clk);
            $display("din=%b, state=%d, y=%b", din, uut.state, y);
        end

        for (i=0; i<7; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 1;
                2: din = 0;
                3: din = 1;
                4: din = 1;
                5: din = 0;
                6: din = 1;
            endcase
            @(posedge clk);
            $display("din=%b, state=%d, y=%b", din, uut.state, y);
        end

        for (i=0; i<16; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 0;
                2: din = 1;
                3: din = 1;
                4: din = 0;
                5: din = 1;
                6: din = 1;
                7: din = 0;
                8: din = 1;
                9: din = 1;
                10: din = 0;
                11: din = 0;
                12: din = 1;
                13: din = 1;
                14: din = 0;
                15: din = 1;
            endcase
            @(posedge clk);
            $display("din=%b, state=%d, y=%b", din, uut.state, y);
        end

        for (i=0; i<9; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 1;
                2: din = 1;
                3: din = 1;
                4: din = 0;
                5: din = 1;
                6: din = 1;
                7: din = 0;
                8: din = 1;
            endcase
            @(posedge clk);
            $display("din=%b, state=%d, y=%b", din, uut.state, y);
        end

        $stop;
    end
endmodule
