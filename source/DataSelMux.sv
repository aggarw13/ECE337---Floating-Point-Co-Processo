// $Id: $
// File name:   DataSelMux.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Data Select Mux for register.
module DataSelMux
  #(
  parameter ADD = 4'b0001,
  parameter SUB = 4'b0010,
  parameter MUL = 4'b0011,
  parameter NEG = 4'b0100,
  parameter ABS = 4'b0101,
  parameter SINE = 4'b0110,
  parameter SRAM = 4'b0111,
  parameter MOV = 4'b1000,
  parameter NONE = 4'b0000
  )
  (
  input wire [3 : 0] Sel,
  input wire [31 : 0] data0,
  input wire [31 : 0] data1,
  input wire [31 : 0] data2,
  input wire [31 : 0] data3,
  input wire [31 : 0] data4,
  input wire [31 : 0] data5,
  input wire [31 : 0] data6,
  input wire [31 : 0] regData,
  input wire [31 : 0] sram_data,
  output reg [31 : 0] out_data
  );
  
  always @ (Sel)
  begin
    out_data = regData;
    case(Sel)
      ADD :
      begin
        out_data = data0;
      end
      
      SUB :
      begin
        out_data = data1;
      end
      
      MUL :
      begin
        out_data = data2;
      end
      
      NEG :
      begin
        out_data = data3;
      end
      
      ABS :
      begin
        out_data = data4;
      end
      
      SINE :
      begin
        out_data = data5;
      end
      
      SRAM :
      begin
        out_data = sram_data;
      end
      
      MOV :
      begin
        out_data = data6;
      end
      
      NONE :
      begin
        out_data = regData;
      end
    endcase
  end
  
  
endmodule