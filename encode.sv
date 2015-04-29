// $Id: $
// File name:   encode.sv
// Created:     4/22/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 6 -> 3 encoder
module encode
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
  input wire en0,
  input wire en1,
  input wire en2,
  input wire en3,
  input wire en4,
  input wire en5,
  input wire sram_en,
  output reg [2 : 0] OpSel
  );
  
  always @ (en0, en1, en2, en3, en4, en5, sram_en)
  begin
    if(en0)
      begin
        OpSel = ADD;
      end
    else if(en1)
      begin
        OpSel = SUB;
      end
    else if(en2)
      begin
        OpSel = MUL;
      end
    else if(en3)
      begin
        OpSel = NEG;
      end
    else if(en4)
      begin
        OpSel = ABS;
      end
    else if(en5)
      begin
        OpSel = SINE;
      end
  else if(sram_en)
    begin
      OpSel = SRAM;
    end
    else
      begin
        OpSel = NONE;
      end
  end
endmodule