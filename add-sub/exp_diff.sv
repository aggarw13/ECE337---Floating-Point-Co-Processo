// $Id: $
// File name:   exp_diff.sv
// Created:     4/15/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Exponent Difference Block.

module exp_diff(
  input wire  [8 : 0] Ea,
  input wire  [8 : 0] Eb,
  output wire [8 : 0] Ediff
  );
  
  //CLA_24bit expDiff(.a(Ea) , .(Eb) , .carry_in(1'b0) , .carry_out
  
  assign Ediff = Ea - Eb;
  
endmodule
