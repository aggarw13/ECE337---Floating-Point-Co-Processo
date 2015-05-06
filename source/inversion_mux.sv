//Mux for calculating 2's complement on Operands Mantissa depending on control signal
module inversion_mux
(
  input wire [23:0] mantissa,
  input wire inversion_control,
  output logic [23:0] updated_mantissa
);

logic [23:0] adder, inverted_mantissa;
logic adder_co;
genvar i;
generate
  for(i = 0; i < 24; i++)
  begin
    assign inverted_mantissa[i] = (inversion_control == 1)? !mantissa[i] : mantissa[i];
  end
endgenerate

assign updated_mantissa = (inversion_control)? inverted_mantissa + 1: mantissa; 

endmodule


  