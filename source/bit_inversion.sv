//Bit Inversion control block for determining bit inversion for operands A and B
//Protocol for eop : 1 for addition and 0 for subtraction
module bit_inversion
(
  input wire [2:0] compare,
  input wire [8:0] exp_diff,
  input wire eop,
  output logic op1_inv,
  output logic op2_inv
);

  assign op1_inv = (!eop && ((exp_diff[7:0] == 0) && compare[1]))? 1'b1 : 1'b0;
  assign op2_inv = (!eop && (((exp_diff[7:0] == 0) && compare[2] | compare[0]) || exp_diff != 0)) ? 1'b1 : 1'b0;
  
  
endmodule




  
   

