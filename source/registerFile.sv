// $Id: $
// File name:   registerFile.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Register file for state Memory.
module registerFile(
  input wire [31 : 0] in_reg0,
  input wire [31 : 0] in_reg1,
  input wire [31 : 0] in_reg2,
  input wire [31 : 0] in_reg3,
  input wire [31 : 0] in_reg4,
  input wire [31 : 0] in_reg5,
  input wire [31 : 0] in_reg6,
  input wire [31 : 0] in_reg7,
  input wire [31 : 0] in_reg8,
  input wire [31 : 0] in_reg9,
  input wire [31 : 0] in_reg10,
  input wire [31 : 0] in_reg11,
  input wire [31 : 0] in_reg12,
  input wire [31 : 0] in_reg13,
  input wire [31 : 0] in_reg14,
  input wire [31 : 0] in_reg15,
  input wire clk,
  input wire nRst,
  output reg [31 : 0]  out_reg0,
  output reg [31 : 0]  out_reg1,
  output reg [31 : 0]  out_reg2,
  output reg [31 : 0]  out_reg3,
  output reg [31 : 0]  out_reg4,
  output reg [31 : 0]  out_reg5,
  output reg [31 : 0]  out_reg6,
  output reg [31 : 0]  out_reg7,
  output reg [31 : 0]  out_reg8,
  output reg [31 : 0]  out_reg9,
  output reg [31 : 0]  out_reg10,
  output reg [31 : 0]  out_reg11,
  output reg [31 : 0]  out_reg12,
  output reg [31 : 0]  out_reg13,
  output reg [31 : 0]  out_reg14,
  output reg [31 : 0]  out_reg15
  );
  //declaring 16 registers
  reg [31 : 0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8 ,reg9, reg10, reg11, reg12, reg13, reg14, reg15;
  
  //creating 16 registers with active low reset
  always @ (posedge clk, negedge nRst)
  begin
    if(nRst == 1'b0)
      begin
        reg0 <= 0;
        reg2 <= 0;
        reg3 <= 0;
        reg4 <= 0;
        reg5 <= 0;
        reg6 <= 0;
        reg7 <= 0;
        reg8 <= 0;
        reg9 <= 0;
        reg10 <= 0;
        reg11 <= 0;
        reg12 <= 0;
        reg13 <= 0;
        reg14 <= 0;
        reg15 <= 0;
        reg1 <= 0;
      end
    else
      begin
        reg0 <= in_reg0;
        reg2 <= in_reg2;
        reg3 <= in_reg3;
        reg4 <= in_reg4;
        reg5 <= in_reg5;
        reg6 <= in_reg6;
        reg7 <= in_reg7;
        reg8 <= in_reg8;
        reg9 <= in_reg9;
        reg10 <= in_reg10;
        reg11 <= in_reg11;
        reg12 <= in_reg12;
        reg13 <= in_reg13;
        reg14 <= in_reg14;
        reg15 <= in_reg15;
        reg1 <= in_reg1;
      end
  end
  
  //assigning output of all the registers
  assign out_reg0 = reg0;
  assign out_reg1 = reg1;
  assign out_reg2 = reg2;
  assign out_reg3 = reg3;
  assign out_reg4 = reg4;
  assign out_reg5 = reg5;
  assign out_reg6 = reg6;
  assign out_reg7 = reg7;
  assign out_reg8 = reg8;
  assign out_reg9 = reg9;
  assign out_reg10 = reg10;
  assign out_reg11 = reg11;
  assign out_reg12 = reg12;
  assign out_reg13 = reg13;
  assign out_reg14 = reg14;
  assign out_reg15 = reg15;
endmodule
  