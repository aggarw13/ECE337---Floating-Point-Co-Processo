// $Id: $
// File name:   exp_mux.sv
// Created:     4/15/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Exponent MUX.

module exp_mux(
  input wire [7 : 0] Ea,
  input wire [7 : 0] Eb,
  input wire diff_sgn,
  output wire [7 : 0] result_exp
  );
  
  assign result_exp = (!diff_sgn)? Ea : Eb ; 
endmodule
