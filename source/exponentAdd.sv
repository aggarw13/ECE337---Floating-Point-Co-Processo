// $Id: $
// File name:   exponentAdd.sv
// Created:     4/20/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: adding exponent in multiplcation

module exponentAdd
  (
    input reg [7:0] exp1,
    input reg [7:0] exp2,
    output reg [8:0] result
  );
  
  reg [8:0] temp;
  
  always @(exp1, exp2) begin
    temp = exp1 + exp2;
    if(temp< 8'b01111111)
      result = 9'b000000000;
    else begin
      temp = temp - 8'b01111111;
      result = temp[8:0];
    end
  end
  
endmodule