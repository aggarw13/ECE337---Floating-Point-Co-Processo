// $Id: $
// File name:   signMul.sv
// Created:     4/21/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: xor the sign bit

module signMul
  (
    input reg sign1,
    input reg sign2,
    output reg signr
  );
  
  assign signr = sign1 ^ sign2;
  
endmodule