// $Id: $
// File name:   tb_sine.sv
// Created:     4/29/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for sine block

`timescale 1ns / 10ps

module tb_sine();
  localparam	CLK_PERIOD	= 5;
  
  reg [31:0] op, result;
  reg sineEna, done;
  reg tb_clk;
  reg tb_nrst;
  reg [3:0] destin, destout;
  reg [31:0] pi4;
  reg [31:0] exout;
  
 	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	sine SINE
  (
    .operand(op),
    .sineEna(sineEna),
    .clk(tb_clk),
    .nrst(tb_nrst),
    .in_dest(destin),
    .result(result),
    .done(done),
    .out_dest(destout)
  );
  
  initial
  begin
    tb_nrst = 1'b0;
    #(CLK_PERIOD);
    tb_nrst = 1'b1;
    op = 32'b00111111010010010000111111011011;
    destin = 4'b0001;
    sineEna = 1'b1;
    #(CLK_PERIOD);
    op = 32'b00111111000001100000101010010010;
    destin = 4'b0010;
    #(CLK_PERIOD);
    op = 32'b00000000000000000000000000000000;
    destin = 4'b0011;
    #(CLK_PERIOD);
    op = 32'b10111111010010010000111111011011;
    destin = 4'b0100;
    #(CLK_PERIOD);
    op = 32'b10111111000001100000101010010010;
    destin = 4'b0101;
    #(CLK_PERIOD);
    op = 32'b00111111010010010000111111011011;
    destin = 4'b0110;
    sineEna = 1'b0;
  end
	
endmodule 