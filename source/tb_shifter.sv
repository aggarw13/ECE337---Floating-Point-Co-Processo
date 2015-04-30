`timescale 1ns / 10ps
module tb_shifter();

localparam NUM_SHIFT_BITS = 8;
localparam SHIFT_DIR = 1;
localparam DELAY = 5;

reg [23:0] tb_mantissa;
reg [NUM_SHIFT_BITS - 1 : 0] tb_shift;
reg [23:0] tb_shifted;
reg [7:0] exp_diff, expA, expB;
reg [2:0] guard_bits;

shifter #(.SHIFT_MODE(1)) shift
  (
   .guard_bits_in('0),
   .guard_bits_out(guard_bits),
   .shift_dir(1'b1),
   .eop(1'b1),
   .ovf(1'b0),
   .mantissa(tb_mantissa),
   .mant_shift(tb_shift),
   .shifted_mantissa(tb_shifted)
  );
  
//exp_diff  EDIFF(.Ea(expA), .Eb(expB), .Ediff(exp_diff));
  
initial begin

  tb_mantissa = 24'h810101;
  expA = 8'h12;
  expB = 8'h10; 
  tb_shift = 8'b00010000;
  #(DELAY);
  
  
end

endmodule
  