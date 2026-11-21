`include "dff_mux.v"
module dff_tb;
reg D,clk;
wire Q,Q_B;

DFF dut(D,clk,Q,Q_B);
initial begin
    clk=0;
    forever #7 clk=~clk;
end
 initial begin 
    repeat(100) begin
     D=$urandom;
     #3;
     end
  end
initial begin
 #200;
 $finish;
 end
 endmodule
