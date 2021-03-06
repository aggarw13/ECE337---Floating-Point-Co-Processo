// $Id: $
// File name:   flex_fifo.sv
// Created:     4/24/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a fifo of variable size for any needed buffers


module flex_fifo
#(
  parameter WIDTH = 8,
  parameter DEPTH = 8,
  parameter BITS_WIDTH = 3,//this is the number of bits needed to make this work
  parameter BITS_DEPTH = 3
)
(
  input wire clk,
  input wire n_rst,
  input wire r_enable,
  
  input wire w_enable,
  input wire[WIDTH -1:0]w_data,
  
  output reg [WIDTH -1:0]r_data,
  output reg full,
  output reg empty
);

localparam ROLLOVERVAL = DEPTH -1;

reg [DEPTH-1:0][WIDTH-1:0] data;
reg [DEPTH-1:0][WIDTH-1:0] nxt_data;

reg w_clear,r_clear;
reg [BITS_DEPTH-1:0]w_pointer;
reg [BITS_DEPTH-1:0]r_pointer;

wire w_roll_flag, r_roll_flag;

genvar i;

flex_indexer #(.NUM_CNT_BITS(BITS_DEPTH) ) Write_pointer //this is the index pointer for the writeside
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(w_clear),
  .count_enable(w_enable && !full),
  .rollover_val(ROLLOVERVAL[BITS_DEPTH-1:0]),
  .count_out(w_pointer),
  .rollover_flag(w_roll_flag)
  
);

flex_indexer #(.NUM_CNT_BITS(BITS_DEPTH) ) Read_pointer //this is the pointer to the read pointer
(
  .clk(clk),
  .n_rst(n_rst),
  .clear(r_clear),
  .count_enable(r_enable && !empty),
  .rollover_val(ROLLOVERVAL[BITS_DEPTH-1:0]),
  .count_out(r_pointer),
  .rollover_flag(r_roll_flag)
);

always_ff @ (posedge clk, negedge n_rst)// this is the regester to store the data
begin
  if(n_rst ==1'b0)
      data <= '0;
    else
      data <=nxt_data;
end

generate
  for (i =0; i <DEPTH; i = i+1)
  begin
  always_comb
  begin
  if (w_pointer == i && w_enable && !full)
    nxt_data[i] = w_data;
  else
    nxt_data[i] = data[i];
  end  
end
endgenerate

always_comb
begin
  if (w_pointer == r_pointer)
    empty = 1;
  else
    empty =0;
  
  if ((w_pointer + 1) % DEPTH == r_pointer)
    full = 1;
  else
    full = 0;

  r_data = data[r_pointer];

end
endmodule
  