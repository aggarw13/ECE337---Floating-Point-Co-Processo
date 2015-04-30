// $Id: $
// File name:   flex_counter.sv
// Created:     1/31/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a flexable counter that can be used in multiple combinations of bits long

module flex_indexer
#(
  parameter NUM_CNT_BITS = 4
)
(
  input wire clk,
  input wire n_rst,
  input wire clear,
  input wire count_enable,
  input wire [(NUM_CNT_BITS - 1):0] rollover_val,
  output reg [(NUM_CNT_BITS - 1):0] count_out,
  output reg rollover_flag
);

  reg [(NUM_CNT_BITS - 1):0] nxt_count;
  reg nxt_rollover_flag;
  
  always_ff @ (posedge clk, negedge n_rst)
  begin
    if( n_rst == 1'b0)
      begin 
        count_out <= '0;
        rollover_flag <= '0;
      end
    else
      begin
        count_out <= nxt_count;
        rollover_flag <= nxt_rollover_flag;
      end
  end
  
  always_comb
  begin
    if (clear == 1'b1)
    begin
      nxt_count = '0;
    end
    else if ( count_enable == 1'b1)
    begin
      if (count_out == rollover_val)
        nxt_count = 1'b0;
      else
        nxt_count = count_out + 1;
    end
    else
    begin
      nxt_count = count_out;
    end
    
    if (nxt_count == rollover_val)
    begin
      nxt_rollover_flag = 1'b0;
    end
  else
    begin
      nxt_rollover_flag = 1'b0;
    end
  end
endmodule
      
    
