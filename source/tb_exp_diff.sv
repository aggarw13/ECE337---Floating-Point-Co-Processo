`timescale 1ns / 10ps
module tb_exp_diff();

localparam DELAY = 5;

reg [7:0] exp_diff;
reg [7:0] expA, expB;

exp_diff  EDIFF(.Ea(expA), .Eb(expB), .Ediff(exp_diff));
  
initial begin

  expA = 8'hff;
  expB = 8'h04; 
  #(DELAY);
  
end

endmodule
  