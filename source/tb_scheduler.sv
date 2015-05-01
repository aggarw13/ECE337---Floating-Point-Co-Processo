// $Id: $
// File name:   tb_scheduler.sv
// Created:     4/25/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: the test bench for the scheduling block

`timescale 1ns / 10ps
module tb_scheduler();
  localparam NUM_TEST_CASES = 32;
  parameter CLK_PERIOD = 10;
  parameter INSTRUCT_WIDTH = 16;
  
  reg tb_clk;
  reg tb_n_rst;
  
  reg [INSTRUCT_WIDTH - 1:0]tb_instruction;
  reg tb_add_instruction;
  reg [15:0]tb_drop_dependency;
  
  reg tb_buffer_full;
  
  reg [7:0]tb_sram_address_store;
  reg [7:0]tb_sram_address_load;
  reg [3:0]tb_source1;
  reg [3:0]tb_source2;
  
  reg tb_store2_enable;
  reg tb_store1_enable;
  reg tb_load_enable;
  reg tb_add_enable;
  reg tb_sub_enable;
  reg tb_mul_enable;
  reg tb_sin_enable;
  reg tb_neg_enable;
  reg tb_abs_enable;
  reg tb_move_enable;
  
  reg [3:0]tb_load_dest;
  reg [3:0]tb_add_dest;
  reg [3:0]tb_sub_dest;
  reg [3:0]tb_mul_dest;
  reg [3:0]tb_sin_dest;
  reg [3:0]tb_neg_dest;
  reg [3:0]tb_abs_dest;
  reg [3:0]tb_move_dest; 
  
  integer tb_test_case;
  integer test_case_num;
  
  reg [1:NUM_TEST_CASES][INSTRUCT_WIDTH - 1:0]test_instruction;
  reg [1:NUM_TEST_CASES]test_add_instruction;
  reg [1:NUM_TEST_CASES][15:0]test_drop_dependency;
  
  reg [1:NUM_TEST_CASES]test_buffer_full;
  
  reg [1:NUM_TEST_CASES][7:0]test_sram_address_store;
  reg [1:NUM_TEST_CASES][7:0]test_sram_address_load;
  reg [1:NUM_TEST_CASES][3:0]test_source1;
  reg [1:NUM_TEST_CASES][3:0]test_source2;
  
  reg [1:NUM_TEST_CASES]test_store2_enable;
  reg [1:NUM_TEST_CASES]test_store1_enable;
  reg [1:NUM_TEST_CASES]test_load_enable;
  reg [1:NUM_TEST_CASES]test_add_enable;
  reg [1:NUM_TEST_CASES]test_sub_enable;
  reg [1:NUM_TEST_CASES]test_mul_enable;
  reg [1:NUM_TEST_CASES]test_sin_enable;
  reg [1:NUM_TEST_CASES]test_neg_enable;
  reg [1:NUM_TEST_CASES]test_abs_enable;
  reg [1:NUM_TEST_CASES]test_move_enable;

  reg [1:NUM_TEST_CASES][3:0]test_load_dest;
  reg [1:NUM_TEST_CASES][3:0]test_add_dest;
  reg [1:NUM_TEST_CASES][3:0]test_sub_dest;
  reg [1:NUM_TEST_CASES][3:0]test_mul_dest;
  reg [1:NUM_TEST_CASES][3:0]test_sin_dest;
  reg [1:NUM_TEST_CASES][3:0]test_neg_dest;
  reg [1:NUM_TEST_CASES][3:0]test_abs_dest;
  reg [1:NUM_TEST_CASES][3:0]test_move_dest; 
  
  scheduler DUT(
  .n_rst(tb_n_rst),
  .clk(tb_clk),
  .instruction(tb_instruction),
  .add_instruction(tb_add_instruction),
  .drop_dependency(tb_drop_dependency),
  
  .buffer_full(tb_buffer_full),
  
  .sram_address_store(tb_sram_address_store),
  .sram_address_load(tb_sram_address_load),
  .source1(tb_source1),
  .source2(tb_source2),
  
  .store2_enable(tb_store2_enable),
  .store1_enable(tb_store1_enable),
  .load_enable(tb_load_enable),
  .add_enable(tb_add_enable),
  .sub_enable(tb_sub_enable),
  .mul_enable(tb_mul_enable),
  .sin_enable(tb_sin_enable),
  .neg_enable(tb_neg_enable),
  .abs_enable(tb_abs_enable),
  .move_enable(tb_move_enable),
  
  .load_dest(tb_load_dest),
  .add_dest(tb_add_dest),
  .sub_dest(tb_sub_dest),
  .mul_dest(tb_mul_dest),
  .sin_dest(tb_sin_dest),
  .neg_dest(tb_neg_dest),
  .abs_dest(tb_abs_dest),
  .move_dest(tb_move_dest) 
  );
  
  always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end
	
	initial
	begin 
	  //reset the test bench
	  tb_n_rst = 1'b1;
	  tb_instruction = '0;
	  tb_add_instruction = 0;
	  tb_drop_dependency = '0;
	  #0.2;
	  tb_n_rst = 1'b0;
	  #0.5;
	  tb_n_rst = 1'b1;
	  @(posedge tb_clk);
	  @(negedge tb_clk);
	  for(tb_test_case = 1; tb_test_case <= NUM_TEST_CASES; tb_test_case++)
	  begin
	    //avoid thr rising edge
	    
	    tb_instruction = test_instruction[tb_test_case];
	    tb_add_instruction = test_add_instruction[tb_test_case];
	    tb_drop_dependency = test_drop_dependency[tb_test_case];
	    //go to the next clk to check
	    @(posedge tb_clk);
	    //go a lot a way but 5ns
	    @(negedge tb_clk);
	     //$info("test case %0d",tb_test_case);
	    if(tb_buffer_full != test_buffer_full[tb_test_case])
	      $info("ERROR: buffer_full not correct for case %0d", tb_test_case);
	    if(tb_sram_address_store != test_sram_address_store[tb_test_case])
	      $info("ERROR: sram_address_store not correct for case %0d", tb_test_case);
	    if(tb_sram_address_load != test_sram_address_load[tb_test_case])
	      $info("ERROR: sram_address_load not correct for case %0d", tb_test_case);
	    if(tb_source1 != test_source1[tb_test_case])
	      $info("ERROR: source1 not correct for case %0d", tb_test_case);
	    if(tb_source2 != test_source2[tb_test_case])
	      $info("ERROR: source2 not correct for case %0d", tb_test_case);
	    if(tb_store2_enable != test_store2_enable[tb_test_case])
	      $info("ERROR: store2_enable not correct for case %0d", tb_test_case);
	    if(tb_store1_enable != test_store1_enable[tb_test_case])
	      $info("ERROR: store1_enable not correct for case %0d", tb_test_case);
	    if(tb_load_enable != test_load_enable[tb_test_case])
	      $info("ERROR: load_enable not correct for case %0d", tb_test_case);
      if(tb_add_enable != test_add_enable[tb_test_case])
	      $info("ERROR: add_enable not correct for case %0d", tb_test_case); 
	    if(tb_sub_enable != test_sub_enable[tb_test_case])
	      $info("ERROR: sub_enable not correct for case %0d", tb_test_case);
	    if(tb_mul_enable != test_mul_enable[tb_test_case])
	      $info("ERROR: mul_enable not correct for case %0d", tb_test_case);
	    if(tb_sin_enable != test_sin_enable[tb_test_case])
	      $info("ERROR: sin_enable not correct for case %0d", tb_test_case); 
	    if(tb_neg_enable != test_neg_enable[tb_test_case])
	      $info("ERROR: neg_enable not correct for case %0d", tb_test_case); 
	    if(tb_abs_enable != test_abs_enable[tb_test_case])
	      $info("ERROR: abs_enable not correct for case %0d", tb_test_case);
	    if(tb_move_enable != test_move_enable[tb_test_case])
	      $info("ERROR: move_enable not correct for case %0d", tb_test_case);
	      
	      if(tb_load_dest != test_load_dest[tb_test_case])
	      $info("ERROR: load_dest not correct for case %0d", tb_test_case); 
	    if(tb_add_dest != test_add_dest[tb_test_case])
	      $info("ERROR: add_dest not correct for case %0d", tb_test_case); 
	    if(tb_sub_dest != test_sub_dest[tb_test_case])
	      $info("ERROR: sub_dest not correct for case %0d", tb_test_case);
	    if(tb_mul_dest != test_mul_dest[tb_test_case])
	      $info("ERROR: mul_dest not correct for case %0d", tb_test_case);
	    if(tb_sin_dest != test_sin_dest[tb_test_case])
	      $info("ERROR: sin_dest not correct for case %0d", tb_test_case); 
	    if(tb_neg_dest != test_neg_dest[tb_test_case])
	      $info("ERROR: neg_dest not correct for case %0d", tb_test_case); 
	    if(tb_abs_dest != test_abs_dest[tb_test_case])
	      $info("ERROR: abs_dest not correct for case %0d", tb_test_case);
	    if(tb_move_dest != test_move_dest[tb_test_case])
	      $info("ERROR: move_dest not correct for case %0d", tb_test_case);
	  end
	  end
	  
	  initial
	  begin
	    //1 do nothing
	    test_case_num = 1;
	    test_instruction[test_case_num] = 16'h000;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h00;
      test_sram_address_load[test_case_num] = 8'h00;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //2attempt to schedule an add, see add on other side
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3123;
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h2;
      test_source2[test_case_num] = 4'h3;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 1;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h1;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //3place an add with no write ,make sure only one add comes out
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3456;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0; 
      
      //4 test the first add again to make sure scheduler follows dependencies
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3123;
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0; 
      
      //5 try with dependency in different position
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0; 
      
      //6 put dependency in source 2
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3231;
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0; 
      
      //7 remove the dependency,  expect first to come out
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3456;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0002;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h2;
      test_source2[test_case_num] = 4'h3;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 1;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h1;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0; 
      
      //8 one cycle wait to simulate alu
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //9 get second result out, ie remove dependency again
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0002;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h1;
      test_source2[test_case_num] = 4'h3;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 1;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h2;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //10 one cycle wait to simulate alu
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      
      //11 try with last dependecy removed to clear fifo
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0004;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h3;
      test_source2[test_case_num] = 4'h1;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 1;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h2;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //12 fill the fifo start by putting in the first instruction again will cause buffer to fill, 1 in
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //13 put somethig else in the fifo. 2
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h2213;//load to 2 from addr 13. 2
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //14 put another thing in fifo. 3
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h4FAB; //F = A-B
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //15 put another thing in.4
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h1BAA; //store reg B to AA
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //16 add next instruction 5
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h5C90; //C=9*0
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //17 add next instruction 6
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h67D6;//7 = sin(D)
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //18 next instruction 7
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h742B; //4 = -2
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //19 next instruction 8
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h8976; //9 = abs(7)
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //20 this should fill the fifo 9
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h9540; //move reg 4 to 5
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 1;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //21 add in one more result just to make sure no overides
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'hAFFF;//would be a store to FF
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 1;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //22 start getting things to schedule
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h3213;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0004;//remove dependency, see result
  
      test_buffer_full[test_case_num] = 1;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h1;
      test_source2[test_case_num] = 4'h3;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 1;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h2;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //23 wait state to unload previous opp
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h0023;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //24 do next opperand which is load
      test_case_num = test_case_num + 1;
	    test_instruction[test_case_num] = 16'h0024;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0004;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h13;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 1;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h2;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //25 do next opperand the subtract
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0025;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0004;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'hA;
      test_source2[test_case_num] = 4'hB;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 1;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'hF;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //26 do the store 2
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0026;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0004;// drop 2 from the list, move is now done
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'hAA;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'hB;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 1;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //27 perform multipy sub is now done
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0027;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h8000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h9;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 1;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'hc;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //28 perform the sine nothing is now dependendt
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0025;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'hD;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 1;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h7;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //29 perform the negation, mul is now done so remove
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0025;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h1000;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h2;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 1;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h4;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
      
      //30 perform absolution,  remove sine
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0025;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0080;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h7;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 1;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h9;
      test_move_dest[test_case_num] = 4'h0;
      
      //31 perform the move, remove negation
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'h0025;
      test_add_instruction[test_case_num] = 0;
      test_drop_dependency[test_case_num] = 16'h0010;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'h0;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h4;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 0;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 1;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h5;
      
      //32 perform a store 1 remove the absolution
      test_case_num = test_case_num + 1;
      test_instruction[test_case_num] = 16'hAFF0;
      test_add_instruction[test_case_num] = 1;
      test_drop_dependency[test_case_num] = 16'h0200;
  
      test_buffer_full[test_case_num] = 0;
  
      test_sram_address_store[test_case_num] = 8'hFF;
      test_sram_address_load[test_case_num] = 8'h0;
      test_source1[test_case_num] = 4'h0;
      test_source2[test_case_num] = 4'h0;
  
      test_store2_enable[test_case_num] = 0;
      test_store1_enable[test_case_num] = 1;
      test_load_enable[test_case_num] = 0;
      test_add_enable[test_case_num] = 0;
      test_sub_enable[test_case_num] = 0;
      test_mul_enable[test_case_num] = 0;
      test_sin_enable[test_case_num] = 0;
      test_neg_enable[test_case_num] = 0;
      test_abs_enable[test_case_num] = 0;
      test_move_enable[test_case_num] = 0;

      test_load_dest[test_case_num] = 4'h0;
      test_add_dest[test_case_num] = 4'h0;
      test_sub_dest[test_case_num] = 4'h0;
      test_mul_dest[test_case_num] = 4'h0;
      test_sin_dest[test_case_num] = 4'h0;
      test_neg_dest[test_case_num] = 4'h0;
      test_abs_dest[test_case_num] = 4'h0;
      test_move_dest[test_case_num] = 4'h0;
	  end
	  
endmodule