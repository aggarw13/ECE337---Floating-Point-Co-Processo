// $Id: $
// File name:   exponentUp.sv
// Created:     4/21/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: update exponent based on normalization of mantissa

module exponentUp
  (
    input reg [8:0] exp1,
    input reg Up,
    output reg [7:0] result
  );
  
  //temporary wire
  reg [9:0] res;
  
  always @(exp1,Up) begin
    if(exp1 == 9'b0) //underflow. set to zero
      result = 8'b00000000;
    else begin
      res = exp1 + Up;
      if(res > 10'b0011111111) //overflow. set to infinity
        result = 8'b11111111;
      else //in all other cases
        result = res[7:0];
    end
  end
  
endmodule