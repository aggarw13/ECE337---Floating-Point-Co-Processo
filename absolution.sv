// $Id: $
// File name:   absolution.sv
// Created:     4/27/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: ALU absolution block.
module absolution(
  input wire [31 : 0] in_value,
  output reg [31 : 0] out_value,
  input wire [3 : 0] in_dest_addr,
  output reg [3 : 0] out_dest_addr,
  output reg done,
  input wire clk,
  input wire nRst,
  input wire en
  );
  reg [31 : 0] in_reg;
  reg [31 : 0] out_reg;
  reg [31 : 0] out_val;
  reg done1;
  reg done2;
  reg addr1;
  reg addr2;
  assign out_val = {1'b0, in_reg[30 : 0]};
  assign out_value = out_reg;
  assign done = done2;
  assign out_dest_addr = addr2;
  
  
  always @ (posedge clk, negedge nRst)
  begin
    if(nRst == 1'b0)
      begin
        in_reg <= 0;
        out_reg <= 0;
        done2 <= 0;
        addr1 <= 0;
        addr2 <= 0;
        done1 <= 0;
        done2 <= 0;
      end
    else
      begin
        addr1 <= in_dest_addr;
        addr2 <= addr1;
        in_reg <= in_value;
        out_reg <= out_val;
        done1 <= en;
        done2 <= done1;
      end
  end
endmodule