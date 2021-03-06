// $Id: $
// File name:   CLA_6bit.sv
// Created:     4/5/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: 24 bit adder for adding aligned operand mantissas
module CLA_24bit(
  input wire carry_in,
  input wire [23 : 0] a,
  input wire [23 : 0] b,
  output logic [23 : 0] sum,
  output reg carry_out
  );
  
  
  //Propagate, Carry Out, Generate registers
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
  
  //Combinational Logic to Calculate Carry-Outs for each bit
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
  
  //Calculating mantisa Addition using optimized built-in library cell
  assign carry_out = c[23];
  assign sum = a + b;
endmodule