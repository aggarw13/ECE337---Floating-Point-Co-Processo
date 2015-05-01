// $Id: $
// File name:   store.sv
// Created:     4/28/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Store from register to SRAM.
module store(
  //input wire [7 : 0] sram_addr,
  input wire [31 : 0] operand,
  input wire clk,
  input wire nRst,
  input wire en,
  output reg [31 : 0] sram_data,
  output reg done
  );
  
  reg [7 : 0] in_out_sram_addr;
  reg [31 : 0] in_out_data;
  reg done_en;
  
  assign done = done_en;
  //assign out_addr = in_out_sram_addr;
  assign sram_data = in_out_data;
  
  always @ (posedge clk, negedge nRst)
  begin
    if(nRst == 1'b0)
      begin
        done_en <= 1'b0;
        in_out_data <= 0;
      end
    else
      begin
        in_out_data <= operand;
        done_en <= en;
      end
  end
endmodule