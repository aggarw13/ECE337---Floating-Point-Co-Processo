// $Id: $
// File name:   tb_StateMemory.sv
// Created:     4/24/2015
// Author:      Akash Kumar
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench for state memory.
`timescale 1ns / 100ps

module tb_StateMemory();
  
  localparam CLK_PERIOD = 2.5;
  localparam CHK_DELAY = CLK_PERIOD/2;
  localparam num_test_cases = 16;

  reg [3 : 0] tb_w_sel0;
  reg [3 : 0] tb_w_sel1;
  reg [3 : 0] tb_w_sel2;
  reg [3 : 0] tb_w_sel3;
  reg [3 : 0] tb_w_sel4;
  reg [3 : 0] tb_w_sel5;
  reg tb_w_en0;
  reg tb_w_en1;
  reg tb_w_en2;
  reg tb_w_en3;
  reg tb_w_en4;
  reg tb_w_en5;
  reg [3 : 0] tb_op1_sel;
  reg [3 : 0] tb_op2_sel;
  reg tb_en_op1;
  reg tb_en_op2;
  reg [31 : 0] tb_Result0;
  reg [31 : 0] tb_Result1;
  reg [31 : 0] tb_Result2;
  reg [31 : 0] tb_Result3;
  reg [31 : 0] tb_Result4;
  reg [31 : 0] tb_Result5;
  reg tb_sram_r_en;
  reg tb_sram_w_en;
  reg [3 : 0] tb_sram_r_sel;
  reg [3 : 0] tb_sram_w_sel;
  reg [31 : 0] tb_write_data;
  reg [31 : 0] tb_op1;
  reg [31 : 0] tb_op2;
  reg [31 : 0] tb_read_data;
  reg [31 : 0] tb_Data_out;
  reg [3 : 0] tb_Data_out_sel;

  reg tb_clk;
  reg tb_nRst;
  
  //Generating Clock
  always
  begin : CLK_GEN
    tb_clk = 1'b1;
    #(CLK_PERIOD/2);
    tb_clk = 1'b0;
    #(CLK_PERIOD/2);
  end
  
  StateMemory DUT( 
  .w_sel0(tb_w_sel0), 
  .w_sel1(tb_w_sel1),
  .w_sel2(tb_w_sel2), 
  .w_sel3(tb_w_sel3), 
  .w_sel4(tb_w_sel4), 
  .w_sel5(tb_w_sel5), 
  .w_en0(tb_w_en0), 
  .w_en1(tb_w_en1),
  .w_en2(tb_w_en2), 
  .w_en3(tb_w_en3), 
  .w_en4(tb_w_en4), 
  .w_en5(tb_w_en5), 
  .en_op1(tb_en_op1), 
  .en_op2(tb_en_op2), 
  .op1_sel(tb_op1_sel),
  .op2_sel(tb_op2_sel),
  .Result0(tb_Result0), 
  .Result1(tb_Result1), 
  .Result2(tb_Result2), 
  .Result3(tb_Result3), 
  .Result4(tb_Result4), 
  .Result5(tb_Result5), 
  .sram_r_en(tb_sram_r_en), 
  .sram_w_en(tb_sram_w_en), 
  .sram_r_sel(tb_sram_r_sel), 
  .sram_w_sel(tb_sram_w_sel),
  .write_data(tb_write_data), 
  .op1(tb_op1), 
  .op2(tb_op2), 
  .read_data(tb_read_data), 
  .Data_out(tb_Data_out), 
  .Data_out_sel(tb_Data_out_sel),
  .clk(tb_clk),
  .nRst(tb_nRst)
  );
  
  //Testing process
  initial
  begin
    //Resest
    tb_nRst = 1'b0;
    #(3*CHK_DELAY);
    tb_nRst = 1'b1;
    //Test Case 1 
    tb_w_sel0 = 2;
    tb_w_sel1 = 4;
    tb_w_sel2 = 10;
    tb_w_sel3 = 7;
    tb_w_sel4 = 5;
    tb_w_sel5 = 1;
    tb_w_en0 = 1;
    tb_w_en1 = 1;
    tb_w_en2 = 1;
    tb_w_en3 = 1;
    tb_w_en4 = 1;
    tb_w_en5 = 1;
    tb_op1_sel = 0;
    tb_op2_sel = 0;
    tb_en_op1 = 0;
    tb_en_op2 = 0;
    tb_Result0 = 77;
    tb_Result1 = 44;
    tb_Result2 = 123;
    tb_Result3 = 140;
    tb_Result4 = 109;
    tb_Result5 = 99;
    tb_sram_r_en = 0;
    tb_sram_w_en = 1;
    tb_sram_r_sel = 0;
    tb_sram_w_sel = 11;
    tb_write_data = 55;
    tb_Data_out_sel = 0;
    #(5*CHK_DELAY);
    tb_Data_out_sel = 2;
    #(3*CHK_DELAY);
    assert(tb_Data_out == 77)
      $info("Test Case PASSED");
    else
      $error("TEst Case FAILED");
    tb_Data_out_sel = 4;
    #(3*CHK_DELAY);
    assert(tb_Data_out == 44)
      $info("Test Case PASSED");
    else
      $error("TEst Case FAILED"); 
    tb_op1_sel = 10;
    #(3*CHK_DELAY);
    assert(tb_op1 == 123)
      $info("Test Case PASSED");
    else
      $error("TEst Case FAILED");
    tb_op2_sel = 5; 
    #(3*CHK_DELAY);
    assert(tb_op2 == 109)
      $info("Test Case PASSED");
    else
      $error("TEst Case FAILED");
    tb_sram_r_sel = 11; 
    #(3*CHK_DELAY);
    assert(tb_read_data == 55)
      $info("Test Case PASSED");
    else
      $error("TEst Case FAILED"); 
   /* #(3*CHK_DELAY);
    assert(tb_Data_out == 44)
      $info("Test Case PASSED");
    else
      $error("TEst Case FAILED"); */
  end
endmodule