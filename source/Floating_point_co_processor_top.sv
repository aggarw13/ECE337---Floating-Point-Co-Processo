//Completely Top Level Module for IC Padding
module Floating_point_co_processor_top(
  input wire apb_clk,
  input wire clk,
  input wire npreset,
  input wire n_rst,
  input wire [31:0] paddr,
  input wire pselec1,
  input wire penable,
  input wire pwrite,
  input wire [31:0] pwdata,
  output logic pready,
  output logic [31:0] prdata,
  output logic pslverr
  );
  
  
  Floating_point_co_processor_design FP_PROCESSOR(
    .apb_clk(apb_clk),
    .clk(clk),
    .npreset(npreset),
    .n_rst(n_rst),
    .paddr(paddr),
    .pselec1(pselec1),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .pready(pready),
    .prdata(prdata),
    .pslverr(pslverr)
  );
  
endmodule