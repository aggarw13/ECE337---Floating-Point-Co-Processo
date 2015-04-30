// $Id: $
// File name:   encodeLayer.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: encode Layer for state memory.
module encodeLayer(
  input wire [6 : 0] en0,
  input wire [6 : 0] en1,
  input wire [6 : 0] en2,
  input wire [6 : 0] en3,
  input wire [6 : 0] en4,
  input wire [6 : 0] en5,
  input wire [6 : 0] en6,
  input wire [6 : 0] en7,
  input wire [6 : 0] en8,
  input wire [6 : 0] en9,
  input wire [6 : 0] en10,
  input wire [6 : 0] en11,
  input wire [6 : 0] en12,
  input wire [6 : 0] en13,
  input wire [6 : 0] en14,
  input wire [6 : 0] en15,
  output wire [2 : 0] OpSel0,
  output wire [2 : 0] OpSel1,
  output wire [2 : 0] OpSel2,
  output wire [2 : 0] OpSel3,
  output wire [2 : 0] OpSel4,
  output wire [2 : 0] OpSel5,
  output wire [2 : 0] OpSel6,
  output wire [2 : 0] OpSel7,
  output wire [2 : 0] OpSel8,
  output wire [2 : 0] OpSel9,
  output wire [2 : 0] OpSel10,
  output wire [2 : 0] OpSel11,
  output wire [2 : 0] OpSel12,
  output wire [2 : 0] OpSel13,
  output wire [2 : 0] OpSel14,
  output wire [2 : 0] OpSel15
  );
  
  encode enc0( .en0(en0[0]), .en1(en0[1]), .en2(en0[2]), .en3(en0[3]), .en4(en0[4]), .en5(en0[5]), .sram_en(en0[6]), .OpSel(OpSel0));
  encode enc1( .en0(en1[0]), .en1(en1[1]), .en2(en1[2]), .en3(en1[3]), .en4(en1[4]), .en5(en1[5]), .sram_en(en1[6]), .OpSel(OpSel1));
  encode enc2( .en0(en2[0]), .en1(en2[1]), .en2(en2[2]), .en3(en2[3]), .en4(en2[4]), .en5(en2[5]), .sram_en(en2[6]), .OpSel(OpSel2));
  encode enc3( .en0(en3[0]), .en1(en3[1]), .en2(en3[2]), .en3(en3[3]), .en4(en3[4]), .en5(en3[5]), .sram_en(en3[6]), .OpSel(OpSel3));
  encode enc4( .en0(en4[0]), .en1(en4[1]), .en2(en4[2]), .en3(en4[3]), .en4(en4[4]), .en5(en4[5]), .sram_en(en4[6]), .OpSel(OpSel4));
  encode enc5( .en0(en5[0]), .en1(en5[1]), .en2(en5[2]), .en3(en5[3]), .en4(en5[4]), .en5(en5[5]), .sram_en(en5[6]), .OpSel(OpSel5));
  encode enc6( .en0(en6[0]), .en1(en6[1]), .en2(en6[2]), .en3(en6[3]), .en4(en6[4]), .en5(en6[5]), .sram_en(en6[6]), .OpSel(OpSel6));
  encode enc7( .en0(en7[0]), .en1(en7[1]), .en2(en7[2]), .en3(en7[3]), .en4(en7[4]), .en5(en7[5]), .sram_en(en7[6]), .OpSel(OpSel7));
  encode enc8( .en0(en8[0]), .en1(en8[1]), .en2(en8[2]), .en3(en8[3]), .en4(en8[4]), .en5(en8[5]), .sram_en(en8[6]), .OpSel(OpSel8));
  encode enc9( .en0(en9[0]), .en1(en9[1]), .en2(en9[2]), .en3(en9[3]), .en4(en9[4]), .en5(en9[5]), .sram_en(en9[6]), .OpSel(OpSel9));
  encode enc10( .en0(en10[0]), .en1(en10[1]), .en2(en10[2]), .en3(en10[3]), .en4(en10[4]), .en5(en10[5]), .sram_en(en10[6]), .OpSel(OpSel10));
  encode enc11( .en0(en11[0]), .en1(en11[1]), .en2(en11[2]), .en3(en11[3]), .en4(en11[4]), .en5(en11[5]), .sram_en(en11[6]), .OpSel(OpSel11));
  encode enc12( .en0(en12[0]), .en1(en12[1]), .en2(en12[2]), .en3(en12[3]), .en4(en12[4]), .en5(en12[5]), .sram_en(en12[6]), .OpSel(OpSel12));
  encode enc13( .en0(en13[0]), .en1(en13[1]), .en2(en13[2]), .en3(en13[3]), .en4(en13[4]), .en5(en13[5]), .sram_en(en13[6]), .OpSel(OpSel13));
  encode enc14( .en0(en14[0]), .en1(en14[1]), .en2(en14[2]), .en3(en14[3]), .en4(en14[4]), .en5(en14[5]), .sram_en(en14[6]), .OpSel(OpSel14));
  encode enc15( .en0(en15[0]), .en1(en15[1]), .en2(en15[2]), .en3(en15[3]), .en4(en15[4]), .en5(en15[5]), .sram_en(en15[6]), .OpSel(OpSel15));
  
  
endmodule