//Mux for 2's complement Inverting Mantissa depending on select signal
module inversion_mux
(
  input wire [23:0] mantissa,
  input wire inversion_control,
  output logic [23:0] updated_mantissa
);

logic [23:0] adder, inverted_mantissa;
logic adder_co;
//assign adder = (inversion_control == 1)? 24'h01 : 24'h00;
genvar i;
generate
  for(i = 0; i < 24; i++)
  begin
    assign inverted_mantissa[i] = (inversion_control == 1)? !mantissa[i] : mantissa[i];
  end
endgenerate

assign updated_mantissa = (inversion_control)? inverted_mantissa + 1: mantissa; 
//CLA_24bit complement (.a(updated_mantissa), .b(adder), .carry_in(1'b0) ,.carry_out(adder_co));

endmodule


  