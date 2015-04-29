// $Id: $
// File name:   StateMemory.sv
// Created:     4/17/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Register File for design.
module StateMemory(
  input wire clk,
  input wire nRst,
  input wire [3 : 0] w_sel0,
  input wire [3 : 0] w_sel1,
  input wire [3 : 0] w_sel2,
  input wire [3 : 0] w_sel3,
  input wire [3 : 0] w_sel4,
  input wire [3 : 0] w_sel5,
  input wire w_en0,
  input wire w_en1,
  input wire w_en2,
  input wire w_en3,
  input wire w_en4,
  input wire w_en5,
  input wire [3 : 0] op1_sel,
  input wire [3 : 0] op2_sel,
  input wire en_op1,
  input wire en_op2,
  input wire [31 : 0] Result0,
  input wire [31 : 0] Result1,
  input wire [31 : 0] Result2,
  input wire [31 : 0] Result3,
  input wire [31 : 0] Result4,
  input wire [31 : 0] Result5,
  input wire sram_r_en,
  input wire sram_w_en,
  input wire [3 : 0] sram_r_sel,
  input wire [3 : 0] sram_w_sel,
  input wire [31 : 0] write_data,
  output wire [31 : 0] op1,
  output wire [31 : 0] op2,
  output wire [31 : 0] read_data,
  output wire [31 : 0] Data_out,
  input wire [3 : 0] Data_out_sel
  );
 
 
  reg [6 : 0] encode0, encode1, encode2, encode3, encode4, encode5, encode6, encode7, encode8, encode9, encode10, encode11, encode12, encode13, encode14, encode15;
  reg [15 : 0] decode0, decode1, decode2, decode3, decode4, decode5,sram_decode;
  reg [2 : 0] OpSel0, OpSel1, OpSel2, OpSel3, OpSel4, OpSel5, OpSel6, OpSel7, OpSel8, OpSel9, OpSel10, OpSel11, OpSel12, OpSel13, OpSel14, OpSel15;
  reg [31 : 0]  out_reg0, out_reg1, out_reg2, out_reg3, out_reg4, out_reg5, out_reg6, out_reg7, out_reg8, out_reg9, out_reg10, out_reg11, out_reg12, out_reg13, out_reg14, out_reg15;
  reg [31 : 0] reg0_data, reg1_data, reg2_data, reg3_data, reg4_data, reg5_data, reg6_data, reg7_data, reg8_data, reg9_data, reg10_data, reg11_data, reg12_data, reg13_data, reg14_data, reg15_data;
  
  //Construction 6 bit Inputs for encode block
  assign encode0 = {sram_decode[0], decode5[0], decode4[0], decode3[0], decode2[0], decode1[0], decode0[0]};
  assign encode1 = {sram_decode[1], decode5[1], decode4[1], decode3[1], decode2[1], decode1[1], decode0[1]};
  assign encode2 = {sram_decode[2], decode5[2], decode4[2], decode3[2], decode2[2], decode1[2], decode0[2]};
  assign encode3 = {sram_decode[3], decode5[3], decode4[3], decode3[3], decode2[3], decode1[3], decode0[3]};
  assign encode4 = {sram_decode[4], decode5[4], decode4[4], decode3[4], decode2[4], decode1[4], decode0[4]};
  assign encode5 = {sram_decode[5], decode5[5], decode4[5], decode3[5], decode2[5], decode1[5], decode0[5]};
  assign encode6 = {sram_decode[6], decode5[6], decode4[6], decode3[6], decode2[6], decode1[6], decode0[6]};
  assign encode7 = {sram_decode[7], decode5[7], decode4[7], decode3[7], decode2[7], decode1[7], decode0[7]};
  assign encode8 = {sram_decode[8], decode5[8], decode4[8], decode3[8], decode2[8], decode1[8], decode0[8]};
  assign encode9 = {sram_decode[9], decode5[9], decode4[9], decode3[9], decode2[9], decode1[9], decode0[9]};
  assign encode10 = {sram_decode[10], decode5[10], decode4[10], decode3[10], decode2[10], decode1[10], decode0[10]};
  assign encode11 = {sram_decode[11], decode5[11], decode4[11], decode3[11], decode2[11], decode1[11], decode0[11]};
  assign encode12 = {sram_decode[12], decode5[12], decode4[12], decode3[12], decode2[12], decode1[12], decode0[12]};
  assign encode13 = {sram_decode[13], decode5[13], decode4[13], decode3[13], decode2[13], decode1[13], decode0[13]};
  assign encode14 = {sram_decode[14], decode5[14], decode4[14], decode3[14], decode2[14], decode1[14], decode0[14]};
  assign encode15 = {sram_decode[15], decode5[15], decode4[15], decode3[15], decode2[15], decode1[15], decode0[15]};
  
  //Construction 3 bit selects for regiter muxes
    
  decodeLayer layer0( 
  .Sel0(w_sel0), 
  .Sel1(w_sel1), 
  .Sel2(w_sel2), 
  .Sel3(w_sel3), 
  .Sel4(w_sel4), 
  .Sel5(w_sel5),
  .sram_w_sel(sram_w_sel), 
  .w_en0(w_en0), 
  .w_en1(w_en1), 
  .w_en2(w_en2), 
  .w_en3(w_en3), 
  .w_en4(w_en4), 
  .w_en5(w_en5),
  .sram_w_en(sram_w_en),
  .out_w_en0(decode0), 
  .out_w_en1(decode1), 
  .out_w_en2(decode2), 
  .out_w_en3(decode3), 
  .out_w_en4(decode4), 
  .out_w_en5(decode5),
  .sram_out_w_en(sram_decode)
  );
  
  encodeLayer layer1( 
  .en0(encode0), 
  .en1(encode1), 
  .en2(encode2), 
  .en3(encode3), 
  .en4(encode4), 
  .en5(encode5), 
  .en6(encode6), 
  .en7(encode7), 
  .en8(encode8), 
  .en9(encode9), 
  .en10(encode10),
  .en11(encode11), 
  .en12(encode12), 
  .en13(encode13), 
  .en14(encode14), 
  .en15(encode15), 
  .OpSel0(OpSel0), 
  .OpSel1(OpSel1), 
  .OpSel2(OpSel2), 
  .OpSel3(OpSel3), 
  .OpSel4(OpSel4), 
  .OpSel5(OpSel5),
  .OpSel6(OpSel6), 
  .OpSel7(OpSel7), 
  .OpSel8(OpSel8), 
  .OpSel9(OpSel9), 
  .OpSel10(OpSel10), 
  .OpSel11(OpSel11), 
  .OpSel12(OpSel12), 
  .OpSel13(OpSel13), 
  .OpSel14(OpSel14), 
  .OpSel15(OpSel15)
  );
  
  regMuxLayer layer2( 
  .data0(Result0), 
  .data1(Result1), 
  .data2(Result2), 
  .data3(Result3), 
  .data4(Result4), 
  .data5(Result5),
  .sram_data(write_data), 
  .Sel0(OpSel0), 
  .Sel1(OpSel1), 
  .Sel2(OpSel2), 
  .Sel3(OpSel3),
  .Sel4(OpSel4), 
  .Sel5(OpSel5), 
  .Sel6(OpSel6), 
  .Sel7(OpSel7), 
  .Sel8(OpSel8), 
  .Sel9(OpSel9), 
  .Sel10(OpSel10), 
  .Sel11(OpSel11), 
  .Sel12(OpSel12), 
  .Sel13(OpSel13), 
  .Sel14(OpSel14), 
  .Sel15(OpSel15),
  .reg0_data(reg0_data), 
  .reg1_data(reg1_data), 
  .reg2_data(reg2_data), 
  .reg3_data(reg3_data), 
  .reg4_data(reg4_data), 
  .reg5_data(reg5_data), 
  .reg6_data(reg6_data), 
  .reg7_data(reg7_data), 
  .reg8_data(reg8_data), 
  .reg9_data(reg9_data), 
  .reg10_data(reg10_data), 
  .reg11_data(reg11_data), 
  .reg12_data(reg12_data), 
  .reg13_data(reg13_data), 
  .reg14_data(reg14_data), 
  .reg15_data(reg15_data),
  .out_reg0(out_reg0), 
  .out_reg1(out_reg1), 
  .out_reg2(out_reg2), 
  .out_reg3(out_reg3), 
  .out_reg4(out_reg4), 
  .out_reg5(out_reg5), 
  .out_reg6(out_reg6), 
  .out_reg7(out_reg7), 
  .out_reg8(out_reg8), 
  .out_reg9(out_reg9), 
  .out_reg10(out_reg10), 
  .out_reg11(out_reg11), 
  .out_reg12(out_reg12), 
  .out_reg13(out_reg13), 
  .out_reg14(out_reg14), 
  .out_reg15(out_reg15)
  );
  
  registerFile regfile( 
  .in_reg0(out_reg0), 
  .in_reg1(out_reg1), 
  .in_reg2(out_reg2), 
  .in_reg3(out_reg3), 
  .in_reg4(out_reg4), 
  .in_reg5(out_reg5), 
  .in_reg6(out_reg6), 
  .in_reg7(out_reg7), 
  .in_reg8(out_reg8), 
  .in_reg9(out_reg9), 
  .in_reg10(out_reg10), 
  .in_reg11(out_reg11), 
  .in_reg12(out_reg12), 
  .in_reg13(out_reg13), 
  .in_reg14(out_reg14), 
  .in_reg15(out_reg15), 
  .clk(clk), 
  .nRst(nRst), 
  .out_reg0(reg0_data), 
  .out_reg1(reg1_data), 
  .out_reg2(reg2_data), 
  .out_reg3(reg3_data), 
  .out_reg4(reg4_data), 
  .out_reg5(reg5_data), 
  .out_reg6(reg6_data), 
  .out_reg7(reg7_data), 
  .out_reg8(reg8_data), 
  .out_reg9(reg9_data), 
  .out_reg10(reg10_data), 
  .out_reg11(reg11_data), 
  .out_reg12(reg12_data), 
  .out_reg13(reg13_data), 
  .out_reg14(reg14_data), 
  .out_reg15(reg15_data)
  );
  
  outSel memOut( 
  .reg0(reg0_data), 
  .reg1(reg1_data), 
  .reg2(reg2_data), 
  .reg3(reg3_data), 
  .reg4(reg4_data), 
  .reg5(reg5_data), 
  .reg6(reg6_data), 
  .reg7(reg7_data), 
  .reg8(reg8_data), 
  .reg9(reg9_data), 
  .reg10(reg10_data), 
  .reg11(reg11_data), 
  .reg12(reg12_data), 
  .reg13(reg13_data), 
  .reg14(reg14_data), 
  .reg15(reg15_data), 
  .DataOutSel(Data_out_sel), 
  .operand1Sel(op1_sel), 
  .operand2Sel(op2_sel), 
  .DataOut(Data_out), 
  .operand1(op1), 
  .operand2(op2), 
  .sram_r_sel(sram_r_sel), 
  .sram_r_data(read_data)
  );
  
endmodule