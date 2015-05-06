// Description: Exponent MUX for Selecting Larger Exponent of the two operands

module exp_mux(
  input wire [7 : 0] Ea,
  input wire [7 : 0] Eb,
  input wire diff_sgn,
  output wire [7 : 0] result_exp
  );
  
  assign result_exp = (!diff_sgn)? Ea : Eb ; 
endmodule
