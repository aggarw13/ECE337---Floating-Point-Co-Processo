// $Id: $
// File name:   regMuxLayer.sv
// Created:     4/23/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: register Mux Layer of state memory.
// 
module regMuxLayer(
  input wire [31 : 0] data0,
  input wire [31 : 0] data1,
  input wire [31 : 0] data2,
  input wire [31 : 0] data3,
  input wire [31 : 0] data4,
  input wire [31 : 0] data5,
  input wire [31 : 0] data6,
  input wire [31 : 0] sram_data,
  input wire [31 : 0] reg0_data,
  input wire [31 : 0] reg1_data,
  input wire [31 : 0] reg2_data,
  input wire [31 : 0] reg3_data,
  input wire [31 : 0] reg4_data,
  input wire [31 : 0] reg5_data,
  input wire [31 : 0] reg6_data,
  input wire [31 : 0] reg7_data,
  input wire [31 : 0] reg8_data,
  input wire [31 : 0] reg9_data,
  input wire [31 : 0] reg10_data,
  input wire [31 : 0] reg11_data,
  input wire [31 : 0] reg12_data,
  input wire [31 : 0] reg13_data,
  input wire [31 : 0] reg14_data,
  input wire [31 : 0] reg15_data,
  input wire [3 : 0] Sel0,
  input wire [3 : 0] Sel1,
  input wire [3 : 0] Sel2,
  input wire [3 : 0] Sel3,
  input wire [3 : 0] Sel4,
  input wire [3 : 0] Sel5,
  input wire [3 : 0] Sel6,
  input wire [3 : 0] Sel7,
  input wire [3 : 0] Sel8,
  input wire [3 : 0] Sel9,
  input wire [3 : 0] Sel10,
  input wire [3 : 0] Sel11,
  input wire [3 : 0] Sel12,
  input wire [3 : 0] Sel13,
  input wire [3 : 0] Sel14,
  input wire [3 : 0] Sel15,
  output reg [31 : 0] out_reg0,
  output reg [31 : 0] out_reg1,
  output reg [31 : 0] out_reg2,
  output reg [31 : 0] out_reg3,
  output reg [31 : 0] out_reg4,
  output reg [31 : 0] out_reg5,
  output reg [31 : 0] out_reg6,
  output reg [31 : 0] out_reg7,
  output reg [31 : 0] out_reg8,
  output reg [31 : 0] out_reg9,
  output reg [31 : 0] out_reg10,
  output reg [31 : 0] out_reg11,
  output reg [31 : 0] out_reg12,
  output reg [31 : 0] out_reg13,
  output reg [31 : 0] out_reg14,
  output reg [31 : 0] out_reg15
  );
  
  DataSelMux mux0( .Sel(Sel0), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg0_data), .sram_data(sram_data), .out_data(out_reg0));
  DataSelMux mux1( .Sel(Sel1), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg1_data), .sram_data(sram_data), .out_data(out_reg1));
  DataSelMux mux2( .Sel(Sel2), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg2_data), .sram_data(sram_data), .out_data(out_reg2));
  DataSelMux mux3( .Sel(Sel3), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg3_data), .sram_data(sram_data), .out_data(out_reg3));
  DataSelMux mux4( .Sel(Sel4), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg4_data), .sram_data(sram_data), .out_data(out_reg4));
  DataSelMux mux5( .Sel(Sel5), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg5_data), .sram_data(sram_data), .out_data(out_reg5));
  DataSelMux mux6( .Sel(Sel6), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg6_data), .sram_data(sram_data), .out_data(out_reg6));
  DataSelMux mux7( .Sel(Sel7), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg7_data), .sram_data(sram_data), .out_data(out_reg7));
  DataSelMux mux8( .Sel(Sel8), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg8_data), .sram_data(sram_data), .out_data(out_reg8));
  DataSelMux mux9( .Sel(Sel9), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg9_data), .sram_data(sram_data), .out_data(out_reg9));
  DataSelMux mux10( .Sel(Sel10), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg10_data), .sram_data(sram_data), .out_data(out_reg10));
  DataSelMux mux11( .Sel(Sel11), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg11_data), .sram_data(sram_data), .out_data(out_reg11));
  DataSelMux mux12( .Sel(Sel12), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg12_data), .sram_data(sram_data), .out_data(out_reg12));
  DataSelMux mux13( .Sel(Sel13), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg13_data), .sram_data(sram_data), .out_data(out_reg13));
  DataSelMux mux14( .Sel(Sel14), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg14_data), .sram_data(sram_data), .out_data(out_reg14));
  DataSelMux mux15( .Sel(Sel15), .data0(data0), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5), .data6(data6), .regData(reg15_data), .sram_data(sram_data), .out_data(out_reg15));
  
endmodule