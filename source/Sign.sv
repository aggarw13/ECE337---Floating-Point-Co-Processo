// $Id: $
// File name:   Sign.sv
// Created:     4/15/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Sign Block for Floating point adder.
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
  
  
  //assign signResult = (expDiff == 0)? ((compare[1] == 1)? signA : !signB)
  
  assign signResult = (compare[2] && expdiff[7:0] == 0 || !expdiff[8])? signA : (operation == 1)?  signB : (!eop ^ signB);
  
  /*always @(eop, signA, signB, signDiff)
  begin
    case(eop)
      SUB : 
      begin
        if(expDiff == 0)
          signResult = (compare[2] == 1)? signA : (signB         
        else if(signA == signB)
          begin 
            if(signDiff == 1'b0)
              signResult = signA;
            else
              signResult = !signB;
          end
        else
          begin
            if(signDiff == 1'b0)
              signResult = signA;
            else
              signResult = signB;
          end
      end
      
      ADD :
      begin
        signResult = signA;
      end
    endcase
  end*/
endmodule
