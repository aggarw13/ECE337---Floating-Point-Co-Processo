// $Id: $
// File name:   store.sv
// Created:     4/28/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Store from register to SRAM.
module store(
  input wire [7 : 0] sram_addr,
  input wire [31 : 0] operand,
  input wire clk,
  input wire nRst,
  input wire en,
  output reg [31 : 0] sram_data,
  output reg done,
  output reg [7 : 0] out_addr,
  output reg w_en
  );
  
  reg [7 : 0] in_sram_addr;
  reg [7 : 0] out_sram_addr;
  reg [31 : 0] in_data;
  reg [31 : 0] out_data;
  reg done1;
  reg done2;
  
  assign done = done2;
  assign w_en = done2;
  assign out_addr = out_sram_addr;
  assign sram_data = out_data;
  
  always @ (posedge clk, negedge nRst)
  begin
    if(nRst == 1'b0)
      begin
        out_data = 0;
        out_sram_addr = 0;
        
      end
    else
      begin
        in_sram_addr <= sram_addr;
        out_sram_addr <= in_sram_addr;
        in_data <= operand;
        out_data <= in_data;
        done1 <= en;
        done2 <= done1;
      end
  end
endmodule