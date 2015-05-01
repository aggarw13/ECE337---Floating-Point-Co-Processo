// $Id: $
// File name:   roundMul.sv
// Created:     4/20/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: rounding for multiplication

module roundMul
  (
    input reg S,
    input reg L,
    input reg G,
    input reg [22:0] mant,
    output reg [22:0] rounded
  );
  
  reg round;
  reg [23:0] round1;
  
  always @(mant,L,G,S) begin
    round = G & (L | S);
    round1 = mant + round;
    rounded = round1[22:0];
  end
  

endmodule