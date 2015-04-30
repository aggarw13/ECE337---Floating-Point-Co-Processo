// $Id: $
// File name:   outSel.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Register file output select.
module outSel
  #(
  parameter REG0 = 4'b0000,
  parameter REG1 = 4'b0001,
  parameter REG2 = 4'b0010,
  parameter REG3 = 4'b0011,
  parameter REG4 = 4'b0100,
  parameter REG5 = 4'b0101,
  parameter REG6 = 4'b0110,
  parameter REG7 = 4'b0111,
  parameter REG8 = 4'b1000,
  parameter REG9 = 4'b1001,
  parameter REG10 = 4'b1010,
  parameter REG11 = 4'b1011,
  parameter REG12 = 4'b1100,
  parameter REG13 = 4'b1101,
  parameter REG14 = 4'b1110,
  parameter REG15 = 4'b1111
  )
  (
  input wire [3 : 0] DataOutSel,
  input wire [3 : 0] operand1Sel,
  input wire [3 : 0] operand2Sel,
  input wire [3 : 0] sram_r_sel,
  input wire [31 : 0]  reg0,
  input wire [31 : 0]  reg1,
  input wire [31 : 0]  reg2,
  input wire [31 : 0]  reg3,
  input wire [31 : 0]  reg4,
  input wire [31 : 0]  reg5,
  input wire [31 : 0]  reg6,
  input wire [31 : 0]  reg7,
  input wire [31 : 0]  reg8,
  input wire [31 : 0]  reg9,
  input wire [31 : 0]  reg10,
  input wire [31 : 0]  reg11,
  input wire [31 : 0]  reg12,
  input wire [31 : 0]  reg13,
  input wire [31 : 0]  reg14,
  input wire [31 : 0]  reg15,
  output reg [31 : 0]  DataOut,
  output reg [31 : 0]  operand1,
  output reg [31 : 0]  operand2,
  output reg [31 : 0]  sram_r_data
  );
  
  //Data Out MUX
  always @ (DataOutSel)
  begin
    case(DataOutSel)
      REG0 :
      begin
        DataOut = reg0;
      end
      
      REG1 :
      begin
        DataOut = reg1;
      end
      
      REG2 :
      begin
        DataOut = reg2;
      end
      
      REG3 :
      begin
        DataOut = reg3;
      end
      
      REG4 :
      begin
        DataOut = reg4;
      end
      
      REG5 :
      begin
        DataOut = reg5;
      end
      
      REG6 :
      begin
        DataOut = reg6;
      end
      
      REG7:
      begin
        DataOut = reg7;
      end
      
      REG8 :
      begin
        DataOut = reg8;
      end
      
      REG9 :
      begin
        DataOut = reg9;
      end
      
      REG10 :
      begin
        DataOut = reg10;
      end
      
      REG11 :
      begin
        DataOut = reg11;
      end
      
      REG12 :
      begin
        DataOut = reg12;
      end
      
      REG13 :
      begin
        DataOut = reg13;
      end
      
      REG14 :
      begin
        DataOut = reg14;
      end
      
      REG15 :
      begin
        DataOut = reg15;
      end
    endcase
  end
  
  always @ (operand1Sel)
  begin
    case(operand1Sel)
      REG0 :
      begin
        operand1 = reg0;
      end
      
      REG1 :
      begin
        operand1 = reg1;
      end
      
      REG2 :
      begin
        operand1 = reg2;
      end
      
      REG3 :
      begin
        operand1 = reg3;
      end
      
      REG4 :
      begin
        operand1 = reg4;
      end
      
      REG5 :
      begin
        operand1 = reg5;
      end
      
      REG6 :
      begin
        operand1 = reg6;
      end
      
      REG7:
      begin
        operand1 = reg7;
      end
      
      REG8 :
      begin
        operand1 = reg8;
      end
      
      REG9 :
      begin
        operand1 = reg9;
      end
      
      REG10 :
      begin
        operand1 = reg10;
      end
      
      REG11 :
      begin
        operand1 = reg11;
      end
      
      REG12 :
      begin
        operand1 = reg12;
      end
      
      REG13 :
      begin
        operand1 = reg13;
      end
      
      REG14 :
      begin
        operand1 = reg14;
      end
      
      REG15 :
      begin
        operand1 = reg15;
      end
    endcase
  end

  always @ (operand2Sel)
  begin
    case(operand2Sel)
      REG0 :
      begin
        operand2 = reg0;
      end
      
      REG1 :
      begin
        operand2 = reg1;
      end
      
      REG2 :
      begin
        operand2 = reg2;
      end
      
      REG3 :
      begin
        operand2 = reg3;
      end
      
      REG4 :
      begin
        operand2 = reg4;
      end
      
      REG5 :
      begin
        operand2 = reg5;
      end
      
      REG6 :
      begin
        operand2 = reg6;
      end
      
      REG7:
      begin
        operand2 = reg7;
      end
      
      REG8 :
      begin
        operand2 = reg8;
      end
      
      REG9 :
      begin
        operand2 = reg9;
      end
      
      REG10 :
      begin
        operand2 = reg10;
      end
      
      REG11 :
      begin
        operand2 = reg11;
      end
      
      REG12 :
      begin
        operand2 = reg12;
      end
      
      REG13 :
      begin
        operand2 = reg13;
      end
      
      REG14 :
      begin
        operand2 = reg14;
      end
      
      REG15 :
      begin
        operand2 = reg15;
      end
    endcase
  end
  
  always @ (sram_r_sel)
  begin
    case(sram_r_sel)
      REG0 :
      begin
        sram_r_data = reg0;
      end
      
      REG1 :
      begin
        sram_r_data = reg1;
      end
      
      REG2 :
      begin
        sram_r_data = reg2;
      end
      
      REG3 :
      begin
        sram_r_data = reg3;
      end
      
      REG4 :
      begin
        sram_r_data = reg4;
      end
      
      REG5 :
      begin
        sram_r_data = reg5;
      end
      
      REG6 :
      begin
        sram_r_data = reg6;
      end
      
      REG7:
      begin
        sram_r_data = reg7;
      end
      
      REG8 :
      begin
        sram_r_data = reg8;
      end
      
      REG9 :
      begin
        sram_r_data = reg9;
      end
      
      REG10 :
      begin
        sram_r_data = reg10;
      end
      
      REG11 :
      begin
        sram_r_data = reg11;
      end
      
      REG12 :
      begin
        sram_r_data = reg12;
      end
      
      REG13 :
      begin
        sram_r_data = reg13;
      end
      
      REG14 :
      begin
        sram_r_data = reg14;
      end
      
      REG15 :
      begin
        sram_r_data = reg15;
      end
    endcase
  end
endmodule