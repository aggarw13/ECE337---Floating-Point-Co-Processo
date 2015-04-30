// $Id: $
// File name:   normalizeMul.sv
// Created:     4/17/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: normalize in multiply

//48 Bit Result coming in
//Normalize (note there will be leading one in first two bits)
//Send the next 23 bit after leading bit out as result mantissa
//Round the bits in this stage too (Last bit, Guard bit, Sticky bit)
module normalizeMul
  (
    input reg [47:0] result,
    output reg eUp,
    output reg [22:0] mantissa,
    output reg L,
    output reg [22:0] Sticky,
    output reg G
  );
  
  /*reg [22:0] mant;
  reg Ltemp;
  reg [22:0] Stemp;
  //reg [22:0] rest;
  //reg [22:0] mant2;
  reg Gtemp;*/
  
  always @(result) begin
    if (result[47] == 1) begin
      mantissa[22:0] = result[46:24];
      eUp = 1'b1;
      L = result[24];
      G = result[23];
      Sticky = result[22:0];
    end 
    else if (result[46] == 1) begin
      mantissa[22:0] = result[45:23];
      eUp = 1'b0;
      L = result[23];
      G = result[22];
      Sticky = {result[21:0],1'b0};
    end else begin
      mantissa[22:0] = 0;
      eUp = 0;
      L = 0;
      G = 0;
      Sticky = 0;
    end
  end  
  
  
  /*always @(rest) begin
      S = rest[0]^rest[1]^rest[2]^rest[3]^rest[4]
      ^rest[5]^rest[6]^rest[7]^rest[8]^rest[9]
      ^rest[10]^rest[11]^rest[12]^rest[13]^rest[14]
      ^rest[15]^rest[16]^rest[17]^rest[18]^rest[19]
      ^rest[20]^rest[21]^rest[22];
      mant2 = mant + (G & (S | L));
  end
  
  always @(mant2) begin
    mantissa = mant2;
  end*/
  
endmodule