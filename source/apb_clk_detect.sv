// Module for detecting APB Clocking Edge

module apb_clk_detect(
  input wire apb_clk,
  input wire nrst,
  input wire system_clk,
  output wire rising_edge_found
  );
  
  reg edge_ff1, edge_ff2;
  assign rising_edge_found = edge_ff1 & !edge_ff2;
 
  
  always @(posedge system_clk, negedge nrst) begin
    if(nrst == 1'b0)
    begin
      edge_ff1 <= 1;
      edge_ff2 <= 1;
    end
  else begin
      edge_ff2 <= edge_ff1;
      edge_ff1 <= apb_clk;
    end
  end
endmodule