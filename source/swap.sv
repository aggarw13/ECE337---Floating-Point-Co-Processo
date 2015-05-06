
//Chooses the mantissa of smaller exponent for right shifting
module swap
(
  input wire [22:0] mantissa_A,
  input wire [22:0] mantissa_B,
  input wire expdiff_sgn,
  output logic [22:0] larger_mantissa,
  output logic [22:0] smaller_mantissa
);

   assign larger_mantissa = (expdiff_sgn == 0)? mantissa_A : mantissa_B;
   assign smaller_mantissa = (expdiff_sgn == 0)? mantissa_B : mantissa_A;
   
 endmodule 
    
     