// $Id: $
// File name:   DataSelMux.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Data Select Mux for register.
module DataSelMux
  #(
  parameter ADD = 3'b001,
  parameter SUB = 3'b010,
  parameter MUL = 3'b011,
  parameter NEG = 3'b100,
  parameter ABS = 3'b101,
  parameter SINE = 3'b110,
  parameter SRAM = 3'b111,
  parameter NONE = 3'b000
  )
  (
  input wire [2 : 0] Sel,
  input wire [31 : 0] data0,
  input wire [31 : 0] data1,
  input wire [31 : 0] data2,
  input wire [31 : 0] data3,
  input wire [31 : 0] data4,
  input wire [31 : 0] data5,
  input wire [31 : 0] regData,
  input wire [31 : 0] sram_data,
  output reg [31 : 0] out_data
  );
  
  always @ (Sel)
  begin
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
      NONE :
      begin
        out_data = regData;
      end
    endcase
  end
  
  
endmodule