`timescale 1ns / 10ps

module tb_module_LOD();

parameter DELAY = 5;
reg sign1;
reg sign2;
reg [7:0] exp_diff;
reg [7:0] op1;
reg [7:0] op2;
wire [7:0] shift;

LOP_nbit count_shift(
  .sign1(sign1),
  .sign2(sign2),
  .exp_diff(exp_diff),
  .op1(op1),
  .op2(op2),
  .shift(shift)
  );
  
initial 
begin
  op1 = 8'h45;
  op2 = 8'h01;
  sign1 = 0;
  sign2 = 0;
  exp_diff = 0;
  #(DELAY);
end
endmodule