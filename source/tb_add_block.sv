//Add block testbench
`timescale 1ns / 10ps
module tb_add_block();

localparam CLK_PERIOD = 5;
localparam NUM_TEST_CASES = 11;
localparam DELAY = 1;

reg [31:0] opA, opB, result;
logic [22:0] tb_mantissa_out;
logic [7:0] exp_out;
reg [3:0] dest_in, dest_out;
reg tb_clk; 
reg nreset;
logic sign_out, write_enable, block_enable;

assign tb_mantissa_out = result[22:0];
assign exp_out =  result[30:23];
assign sign_out = result[31];

always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

subtract_block ADD 
(
 .opA(opA),
 .opB(opB),
 .clk(tb_clk),
 .nreset(nreset),
 .result(result),
 .write_enable(write_enable),
 .dest_in(dest_in),
 .reg_dest(dest_out),
 .new_instr(block_enable)
  );
 
 reg [1:NUM_TEST_CASES] [22:0] mantissa_A;
 reg [1:NUM_TEST_CASES] [22:0] mantissa_B;
 reg [1:NUM_TEST_CASES] [7:0] exp_A; 
 reg [1:NUM_TEST_CASES] [7:0] exp_B;
 reg [1:NUM_TEST_CASES] sign_A;
 reg [1:NUM_TEST_CASES] sign_B;
 reg [1:NUM_TEST_CASES] [31:0] expected_sign;
 integer i;
 
initial begin //Can add an overflow case (underflow is already present)
  //Test Case 1 : Basic Addition of Same Exponent FP numbers
  mantissa_A[1] = 23'b00000000001000100000000;
  mantissa_B[1] = 23'b00000000010001000000010;
  exp_A[1] = 8'h04;
  exp_B[1] = 8'h04;
  sign_A[1] = 0;
  sign_B[1] = 0; 
  expected_sign[1] = 1'b0;
  
  //Test Case 2 : Adding two Same exponent (of 128) Negative FP numbers 
  mantissa_A[2] = 23'b00010000011100101010000;
  mantissa_B[2] = 23'b00010000010101001010010;
  exp_A[2] = 8'hf8;
  exp_B[2] = 8'hf8;
  sign_A[2] = 1;
  sign_B[2] = 1;
  expected_sign[2] = 1'b1;
  
  //Test Case 3 : Adding basic FP numbers with positive exponent difference
  mantissa_A[3] = 23'b00010001001000100000000;
  mantissa_B[3] = 23'b00101001010001000000010;
  exp_A[3] = 8'h08;
  exp_B[3] = 8'h07;
  sign_A[3] = 0;
  sign_B[3] = 0;
  expected_sign[3] = 1'b0;
  
  //Test Case 4 : Adding two FP numbers with negative exponent difference
  mantissa_A[4] = 23'b00000000001000100000000;
  mantissa_B[4] = 23'b00000000010001000000010;
  exp_A[4] = 8'h04;
  exp_B[4] = 8'h0f;
  sign_A[4] = 0;
  sign_B[4] = 0;
  expected_sign[4] = 1'b0;
  
  //Test Case 5 : Effect subtraction of two large exponent difference FP numbers for positive result
  mantissa_A[5] = 23'b11111110001000100000000;
  mantissa_B[5] = 23'b00100000010001000000010;
  exp_A[5] = 8'h1f;
  exp_B[5] = 8'h0f;
  sign_A[5] = 0;
  sign_B[5] = 1;
  expected_sign[5] = 1'b0;
  
  //Test Case 6 : Effective subtraction of two large exponent difference FP numbers with negative result
  mantissa_A[6] = 23'b11111110001000100000000;
  mantissa_B[6] = 23'b10100000010001000000010;
  exp_A[6] = 8'h1f;
  exp_B[6] = 8'h0f;
  sign_A[6] = 1;
  sign_B[6] = 0;
  expected_sign[6] = 1'b1;
  
  //Test Case 7 : Effect subtraction of same exponents' Negative FP numbers
  mantissa_A[7] = 23'b11111110001000100000000;
  mantissa_B[7] = 23'b11110101010101000000010;
  exp_A[7] = 8'h1f;
  exp_B[7] = 8'h1f;
  sign_A[7] = 0;
  sign_B[7] = 1;
  expected_sign[7] = 1'b0;
  
  //Test Case 8 : Effect adition of same exponents' large Negative FP numbers
  mantissa_A[8] = 23'b00111110001000100000000;
  mantissa_B[8] = 23'b10110101010101000000010;
  exp_A[8] = 8'h1f;
  exp_B[8] = 8'h1f;
  sign_A[8] = 1;
  sign_B[8] = 1;
  expected_sign[8] = 1'b1;

  //Test Case 9 : Effective Addition for Overflow Case
  mantissa_A[9] = 23'b11111110001000100000000;
  mantissa_B[9] = 23'b11110101010101000000010;
  exp_A[9] = 8'hff;
  exp_B[9] = 8'hff;
  sign_A[9] = 1;
  sign_B[9] = 1; 
  expected_sign[9] = 1'b0;
  
  //Test Case 10 : Effective Subtraction for Underflow (expected sign is negative)
  mantissa_A[10] = 23'b10111110001000100000000;
  mantissa_B[10] = 23'b10111101010101000000010;
  exp_A[10] = 8'h03;
  exp_B[10] = 8'h03;
  sign_A[10] = 0;
  sign_B[10] = 1;
  expected_sign[10] = 1'b0;
  
  //Test Case 11 : NaN operand is input (for NaN ouput expectation)
  mantissa_A[11] = 23'b10111110001000100000000;
  mantissa_B[11] = 23'b10111101010101000000010;
  exp_A[11] = 8'hff;
  exp_B[11] = 8'h03;
  sign_A[11] = 0;
  sign_B[11] = 1;
  expected_sign[11] = 1'b0;
  
end

initial begin
  nreset = 1'b1;
  @(negedge tb_clk);
  opA = '0;
  opB = '0;
  dest_in = 4'h3;
  @(posedge tb_clk);
  for(i = 1; i <= NUM_TEST_CASES; i++) begin
    @(negedge tb_clk);
    if(i <= NUM_TEST_CASES) begin
      block_enable = 1'b1;  
      opA = {sign_A[i],exp_A[i],mantissa_A[i]};
      opB = {sign_B[i],exp_B[i],mantissa_B[i]};
    end
    if(i >= 4) begin
      assert(sign_out == expected_sign[i - 3])
        $info("The result sign is CORRECT for test case : %d", i - 3);
      else
        $error("The result sign is INCORRECT for test case : %d", i - 3);
    end
    @(posedge tb_clk);
    #(DELAY);
    if(i == 4) begin
      block_enable = 1'b0;
      @(posedge tb_clk);
    end
  end
end
endmodule