// $Id: $
// File name:   CLA_6bit.sv
// Created:     4/5/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Carry Look Ahead 6 bit adder.
module CLA_24bit(
  input wire carry_in,
  input wire [23 : 0] a,
  input wire [23 : 0] b,
  output logic [23 : 0] sum,
  output reg carry_out
  );
  
  reg [23 : 0] p;
  reg [23 : 0] c;
  reg [23 : 0] g;
  reg t;
  
  genvar i;
  integer j;
  integer k;
  integer l;
  
  generate
    for(i = 0; i < 24; i = i + 1)
    begin
      assign g[i] = a[i]&b[i];
      assign p[i] = a[i]^b[i];
    end
    
  endgenerate
  
  
  always_comb
  begin
    for(l = 0;l < 24; l = l + 1)
    begin
      c[l] = g[l];
      for(j = l - 1; j >= 0; j--)
      begin
        t = g[j];
        for(k = j; k <= l; k = k + 1)
        begin
          t = t & p[k];
        end
        c[l] = c[l] || t;
      end
      t = carry_in;
      for(j = 0; j <= l; j = j + 1)
      begin
        t = t & p[j];
      end
      c[l] = c[l] || t;
    end

  end
  
  //assign c[0] = g[0]||(carry_in&p[0]);
  //assign c[1] = g[1]||(g[0]&p[1])||(carry_in&p[0]&p[1]);
  //assign c[2] = g[2]||(g[1]&p[2])||(g[0]&p[1]&p[2])||(carry_in&p[0]&p[1]&p[2]);
  //assign c[3] = g[3]||(g[2]&p[3])||(g[1]&p[2]&p[3])||(g[0]&p[1]&p[2]&p[3])||(carry_in&p[0]&p[1]&p[2]&p[3]);
  //assign c[4] = g[4]||(g[3]&p[4])||(g[2]&p[3]&p[4])||(g[1]&p[2]&p[3]&p[4])||(g[0]&p[1]&p[2]&p[3]&p[4])||(carry_in&p[0]&p[1]&p[2]&p[3]&p[4]);
  //assign c[5] = g[5]||(g[4]&p[5])||(g[3]&p[4]&p[5])||(g[2]&p[3]&p[4]&p[5])||(g[1]&p[2]&p[3]&p[4]&p[5])||(g[0]&p[1]&p[2]&p[3]&p[4]&p[5])||(carry_in&p[0]&p[1]&p[2]&p[3]&p[4]&p[5]);
  
  assign carry_out = c[23];
  //assign sum[0] = carry_in^p[0];
  assign sum = a + b;
  /*generate
    for(i = 1; i < 24; i = i + 1)
    begin
      assign sum[i] = c[i - 1]^p[i];
    end
  endgenerate*/ 
endmodule