// $Id: $
// File name:   exp_result.sv
// Created:     4/15/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Exponent Result Block.
module exp_result(
  input wire [7 : 0] in_exp,
  input wire ovf,
  output wire [7 : 0] out_exp
  );
  
  assign out_exp = (ovf == 1)? in_exp[7:1] + 1 : in_exp;
endmodule
