`timescale 1ns / 1ps

module tb_light;
    reg clk, rst, tick;
    wire ns_g, ns_y, ns_r, ew_g, ew_y, ew_r;

    traffic_light_fsm uut (
        .clk(clk), .rst(rst), .tick(tick),
        .ns_g(ns_g), .ns_y(ns_y), .ns_r(ns_r),
        .ew_g(ew_g), .ew_y(ew_y), .ew_r(ew_r)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    reg [4:0] div;

    always @(posedge clk) begin
        if (rst) begin
            div <= 0;
            tick <= 0;
        end 
        else begin
            if (div == 20) begin
                tick <= 1;
                div <= 0;
            end 
            else begin
                tick <= 0;
                div <= div + 1;
            end
        end
    end

    initial begin
        rst = 1; #20;
        rst = 0; #50000;
        $finish;
    end

    initial begin
        $dumpfile("wave_light.vcd");
        $dumpvars(1, tb_light);
    end
endmodule
