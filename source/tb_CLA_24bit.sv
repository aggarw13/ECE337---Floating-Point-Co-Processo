// $Id: $
// File name:   tb_CLA_6bit.sv
// Created:     4/5/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for 6 bit Carry Look Ahead adder.
`timescale 1ns / 100ps

module tb_CLA_24bit();
  
  localparam NUM_INPUT_BITS = 6;
  localparam CLK_PERIOD = 1;
  localparam CHK_DELAY = CLK_PERIOD;
  localparam NUM_TEST_CASES = 3;
  
  reg [23 : 0] tb_a;
  reg [23 : 0] tb_b;
  reg tb_carry_in;
  reg tb_carry_out;
  reg [23 : 0] tb_sum;
  reg [23 : 0] tb_sum_expected;
  
  CLA_24bit DUT( .carry_in(tb_carry_in), .a(tb_a), .b(tb_b), .sum(tb_sum), .carry_out(tb_carry_out));
  
  initial
  begin
    tb_a = 24'b001101000000000000000000;
    tb_b = 24'b010010001000010000100000;
    tb_carry_in = 0;
    tb_sum_expected = tb_a + tb_b;
    #(CHK_DELAY);
    #(CHK_DELAY);
    assert(tb_sum == tb_sum_expected)
      $info("test Case PASSED sum = %d, %d",tb_sum, tb_sum_expected);
    else
      $error("Test Case Failed sum = %d, %d", tb_sum, tb_sum_expected);
  end
endmodule