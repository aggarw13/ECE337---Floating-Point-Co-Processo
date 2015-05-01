// $Id: $
// File name:   mul24.sv
// Created:     4/17/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: multiply 24 bits (23 bits input, add one as MSB for denormalizing)

module mul24
  (
    input reg [22:0] a,
    input reg [22:0] b,
    output reg [47:0] result
  );
  
  //integer i;
  //reg [47:0] p;
  reg [23:0] newa;
  reg [23:0] newb;
  
  assign newa [23:0] = {1'b1,a};
  assign newb [23:0] = {1'b1,b};

  /*always @(newa or newb) begin
    p = 0;
    for (i=0; i<24; i=i+1)
      if (newa[i] == 1'b1 )
        p = p + (newb << i );
  end*/
  
  always @(newa or newb) 
    result = newa * newb;

endmodule