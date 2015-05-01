// $Id: $
// File name:   encode.sv
// Created:     4/22/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 6 -> 3 encoder
module encode
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
  input wire en0,
  input wire en1,
  input wire en2,
  input wire en3,
  input wire en4,
  input wire en5,
  input wire en6,
  input wire sram_en,
  output reg [3 : 0] OpSel
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
    else if(en6)
      begin
        OpSel = MOV;
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