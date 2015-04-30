// $Id: $
// File name:   round.sv
// Created:     4/15/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Round mantissa Block.
module round(
  input wire [25 : 0] result,
  input wire eop,
  output wire [22 : 0] rnd_result
  );
  
  reg G, R, T, L;
  reg rnd;
  reg [22 : 0] mantissa;
  assign mantissa = result[25:3];
  assign T = result[0];
  assign R = result[1];
  assign G = result[2];
  assign L = result[3];
  assign rnd = G & (L | R | T);
  assign rnd_result = (eop)? mantissa + rnd : mantissa - rnd;
endmodule
