module DFF(D, clk, Q, Q_B);
input wire D;
input wire clk;
output wire Q,Q_B;
wire Y;
   //for +ve edge trigger D-FF
    mux2X1 dut1 ({D,Y}, clk, Y);
    mux2X1 dut2 ({Q,Y}, clk, Q);
   assign Q_B = ~Q;
endmodule

module mux2X1(I,S,Y);
input [1:0]I;
input S;
output Y;
assign Y=S?I[0]:I[1];
endmodule
