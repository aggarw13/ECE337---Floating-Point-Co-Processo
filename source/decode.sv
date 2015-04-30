// $Id: $
// File name:   decode.sv
// Created:     4/22/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 4 -> 16 decoeder.
module decode
  (
  input wire [3 : 0] Sel,
  input wire w_en,
  output reg [15 : 0] out_w_en
  );
  
  integer i;
  always @ (w_en, Sel)
  begin
    out_w_en = 0;
      for(i = 0; i < 16; i = i + 1)
      begin
        if(Sel == i)
          begin
            out_w_en[i] = w_en;
          end
      end  
  end
endmodule