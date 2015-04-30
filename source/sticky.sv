// $Id: $
// File name:   sticky.sv
// Created:     4/20/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Sticky bit for rounding

module sticky
  (
    input reg[22:0] rest,
    output reg S
  );
  
   assign S = rest[0]^rest[1]^rest[2]^rest[3]^rest[4]
      ^rest[5]^rest[6]^rest[7]^rest[8]^rest[9]
      ^rest[10]^rest[11]^rest[12]^rest[13]^rest[14]
      ^rest[15]^rest[16]^rest[17]^rest[18]^rest[19]
      ^rest[20]^rest[21]^rest[22];
  
endmodule