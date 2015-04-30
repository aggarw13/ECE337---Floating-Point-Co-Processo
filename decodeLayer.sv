// $Id: $
// File name:   decodeLayer.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: decode Layer of state memory.
module decodeLayer(
  input wire [3 : 0] Sel0,
  input wire [3 : 0] Sel1,
  input wire [3 : 0] Sel2,
  input wire [3 : 0] Sel3,
  input wire [3 : 0] Sel4,
  input wire [3 : 0] Sel5,
  input wire [3 : 0] sram_w_sel,
  input wire w_en0,
  input wire w_en1,
  input wire w_en2,
  input wire w_en3,
  input wire w_en4,
  input wire w_en5,
  input wire sram_w_en,
  output wire [15 : 0] out_w_en0,
  output wire [15 : 0] out_w_en1,
  output wire [15 : 0] out_w_en2,
  output wire [15 : 0] out_w_en3,
  output wire [15 : 0] out_w_en4,
  output wire [15 : 0] out_w_en5,
  output wire [15 : 0] sram_out_w_en
  );
  
  decode dec0( .Sel(Sel0), .w_en(w_en0), .out_w_en(out_w_en0));
  decode dec1( .Sel(Sel1), .w_en(w_en1), .out_w_en(out_w_en1));
  decode dec2( .Sel(Sel2), .w_en(w_en2), .out_w_en(out_w_en2));
  decode dec3( .Sel(Sel3), .w_en(w_en3), .out_w_en(out_w_en3));
  decode dec4( .Sel(Sel4), .w_en(w_en4), .out_w_en(out_w_en4));
  decode dec5( .Sel(Sel5), .w_en(w_en5), .out_w_en(out_w_en5));
  decode dec6( .Sel(sram_w_sel), .w_en(sram_w_en), .out_w_en(sram_out_w_en));
endmodule