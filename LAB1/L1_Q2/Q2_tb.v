`timescale 1ns / 1ns
module Q2_tb;

  reg [3:0] x, y;
  wire c;

  Q2 uut (
    .A(x),
    .B(y),
    .C(c)
  );

  initial begin
    $dumpfile("Q2.vcd");
    $dumpvars(0, Q2_tb);

    x = 4'b0000; y = 4'b0000; 
    #10;
    x = 4'b1010; y = 4'b1010; 
    #10;
    x = 4'b1111; y = 4'b0000; 
    #10;
    x = 4'b0011; y = 4'b1100; 
    #10;
    x = 4'b1001; y = 4'b1001; 
    #10;

    $finish;
  end

endmodule
