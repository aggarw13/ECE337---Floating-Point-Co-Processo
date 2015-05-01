// $Id: $
// File name:   tb_multiply.sv
// Created:     4/21/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for floating point multiplication

`timescale 1ns / 10ps

module tb_multiply();
  localparam	CLK_PERIOD	= 5;
  
  reg tb_clk;
  reg tb_nrst;
  reg [31:0] op1;
  reg [31:0] op2;
  reg [31:0] ans;
  //reg [22:0] mant;
  //reg [7:0] exp;
  reg done;
  reg enable;
  reg [3:0] dest;
  reg [3:0] odest;
  
 	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	multiply FMUL(
	 .clk(tb_clk),
	 .nrst(tb_nrst),
	 .operand1(op1),
	 .operand2(op2),
	 .mulEna(enable),
	 .in_dest(dest),
	 .result(ans),
	 //.mant(mant),
	 //.exp(exp),
	 .done(done),
	 .out_dest(odest)
	);
  
  initial
  begin
    tb_nrst = 1'b0;
    enable = 1'b0;
    #(CLK_PERIOD * 2);
    tb_nrst = 1'b1;
    @(posedge tb_clk);
    #(0.2)
    enable = 1'b1;
    op1 = 32'b00111111100111010111000010100100;
    op2 = 32'b01000000000101011100001010001111;
    dest = 4'b1000;
    #(CLK_PERIOD);
    op1 = 32'b01000001010100011001100110011010;
    op2 = 32'b01000000010011001100110011001101;
    dest = 4'b1001;
    #(CLK_PERIOD);
    op1 = 32'b11000001010001010111000010100100;
    op2 = 32'b01000000111111001100110011001101;
    dest = 4'b1010;
    #(CLK_PERIOD);
    op1 = 32'b01010000101110100100001110110111;
    op2 = 32'b11010101001011101001111101111100;
    dest = 4'b1011;
    #(CLK_PERIOD);
    op1 = 32'b00101111100010010111000001011111;
    op2 = 32'b10101010000001110001101110100101;
    dest = 4'b1100;
    @(negedge tb_clk);
    if(ans == 32'b01000000001110000011010001101110)
      $info("Case 1 (1.23*2.34) success");
    @(negedge tb_clk);
    op1 = 32'b01111111101001101011101011110011;
    op2 = 32'b10101010000001110001101110100101;
    dest = 4'b1101;
    if(ans == 32'b01000010001001111010111000010100)
      $info("Case 2 (13.1 * 3.2) success");
    @(negedge tb_clk);
    op1 = 32'b00010101111101111001011010001000;
    op2 = 32'b00010101111101111001011010001000;
    dest = 4'b1110;
    if(ans == 32'b11000010110000101111100011010101)
      $info("Case 3 (-12.34 * 7.9) success");
    @(negedge tb_clk);
    op1 = 32'b01101001000001000101100101010001;
    op2 = 32'b01101001000001000101100101010001;
    dest = 4'b0001;
    if(ans == 32'b11100110011111100001110000100001)
      $info("Case 4 (2.5e10 * -1.2e13) success");
    @(negedge tb_clk);
    enable = 1'b0;
    op1 = 32'b00111111100111010111000010100100;
    op2 = 32'b01000000000101011100001010001111;
    dest = 4'b1111;
    if(ans == 32'b10011010000100010001001000110011)
      $info("Case 5 (2.5e-10 * -1.2e-13) success");
    @(negedge tb_clk);
    if(ans == 32'b11111111100000000000000000000001)
      $info("Case 6 NaN success");
    @(negedge tb_clk);
    if(ans == 32'b00000000000000000000000000000000)
      $info("Case 7 Underflow success");
    @(negedge tb_clk);
    if(ans == 32'b01111111100000000000000000000000)
      $info("Case 8 Overflow success");
    @(negedge tb_clk);
    if(ans == 32'b01111111100000000000000000000000)
      $info("Case 9 enable off success");
    enable = 1'b1;
    op1 = 32'b00111111100111010111000010100100;
    op2 = 32'b01000000000101011100001010001111;
    dest = 4'b1000;
    #(CLK_PERIOD);
    #(CLK_PERIOD);
    enable = 1'b0;
    #(CLK_PERIOD);
    #(CLK_PERIOD);
    enable = 1'b1;
    op1 = 32'b01000001010100011001100110011010;
    op2 = 32'b01000000010011001100110011001101;
    dest = 4'b1001;
    #(CLK_PERIOD);
    enable = 1'b0;
  end
  
endmodule