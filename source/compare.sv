
// Compares the mantissas of the operands required for the case of equal exponents 
module compare #(
   NUM_BITS = 23
   )
  (
   input wire [NUM_BITS - 1 : 0] mantissa1,
   input wire [NUM_BITS - 1 : 0] mantissa2,
   output logic [2:0] compare
   );
   
   comparator mantissa_comp (.a(mantissa1), .b(mantissa2), .eq(compare[0]), .lt(compare[1]), .gt(compare[2]));
   
 endmodule  
   
   
   
   
   
   
   
    
    