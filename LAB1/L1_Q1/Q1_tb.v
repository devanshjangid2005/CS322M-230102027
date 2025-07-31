`timescale 1ns / 1ns
module Q1_tb;

  reg x,y;
  wire O1,O2,O3;

  Q1 uut (
    .A(x),
    .B(y),
    .o1(O1),
    .o2(O2),
    .o3(O3)
  );

  initial begin
    $dumpfile("Q1.vcd");
    $dumpvars(0, Q1_tb);

    x = 0; y = 0; 
    #10;
    x = 0; y = 1; 
    #10;
    x = 1; y = 0; 
    #10;
    x = 1; y = 1; 
    #10;

    $finish;
  end

endmodule
