// Description: Sign Determination for Floating point adder/subtractor.
module Sign
  #(
  parameter SUB = 0,
  parameter ADD = 1
  )
  (
  input wire eop,
  input wire signA,
  input wire signB,
  input wire operation,
  input wire [8:0] expdiff,
  input wire [2:0] compare,
  output reg signResult
  );
   
  assign signResult = (compare[2] && expdiff[7:0] == 0 || !expdiff[8])? signA : (operation == 1)?  signB : (!eop ^ signB);
  
endmodule
