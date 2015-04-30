// $Id: $
// File name:   tb_scheduling_logic.sv
// Created:     4/21/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a test bench for the sceduling logic of the scheduler

`timescale 1ns / 10ps

module tb_scheduling_logic();
  localparam NUM_TEST_CASES = 34;
  parameter CLK_PERIOD = 5;
  
  reg tb_clk;
  reg tb_n_rst;
  
  reg [15:0]tb_instruction1;
  reg [15:0]tb_dependency;
  reg tb_instruction_available;
  
  reg [15:0]tb_dependency_add;
  reg [7:0]tb_sram_address_store;
  reg [7:0]tb_sram_address_load;
  reg [3:0]tb_source1;
  reg [3:0]tb_source2;
  
  reg tb_read_instruction1;
  
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
  
  reg [3:0]tb_add_dest;
  reg [3:0]tb_sub_dest;
  reg [3:0]tb_mul_dest;
  reg [3:0]tb_sin_dest;
  reg [3:0]tb_neg_dest;
  reg [3:0]tb_abs_dest;
  reg [3:0]tb_move_dest;
  
  integer tb_test_case;
  integer test_case_num;
  reg [1:NUM_TEST_CASES][15:0]test_instruction1;
  reg [1:NUM_TEST_CASES][15:0]test_dependency;
  reg [1:NUM_TEST_CASES]test_instruction_available;
  
  reg [1:NUM_TEST_CASES][15:0]test_dependency_add;
  reg [1:NUM_TEST_CASES][7:0]test_sram_address_store;
  reg [1:NUM_TEST_CASES][7:0]test_sram_address_load;
  reg [1:NUM_TEST_CASES][3:0]test_source1;
  reg [1:NUM_TEST_CASES][3:0]test_source2;
  
  reg [1:NUM_TEST_CASES]test_read_instruction1;
  
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
  
  reg [1:NUM_TEST_CASES][3:0]test_add_dest;
  reg [1:NUM_TEST_CASES][3:0]test_sub_dest;
  reg [1:NUM_TEST_CASES][3:0]test_mul_dest;
  reg [1:NUM_TEST_CASES][3:0]test_sin_dest;
  reg [1:NUM_TEST_CASES][3:0]test_neg_dest;
  reg [1:NUM_TEST_CASES][3:0]test_abs_dest;
  reg [1:NUM_TEST_CASES][3:0]test_move_dest;
  
  scheduling_logic DUT
  (
  .instruction1(tb_instruction1),
  .dependency(tb_dependency),
  .dependency_add(tb_dependency_add),
  .instruction_available(tb_instruction_available),
  
  .sram_address_store(tb_sram_address_store),
  .sram_address_load(tb_sram_address_load),
  .source1(tb_source1),
  .source2(tb_source2),
  
  .read_instruction1(tb_read_instruction1),
  
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
    tb_n_rst = 1'b1;
	  tb_instruction1 = '0;
	  tb_dependency = '0;
	  tb_instruction_available = 0;
	  #0.1
	  tb_n_rst = 1'b0;
	  #0.1
	  tb_n_rst = 1'b1;
	  @(posedge tb_clk);
	  for (tb_test_case = 1; tb_test_case <= NUM_TEST_CASES; tb_test_case++)
	  begin
	    @(negedge tb_clk);
	    tb_instruction1 = test_instruction1[tb_test_case];
      tb_dependency = test_dependency[tb_test_case];
      tb_instruction_available = test_instruction_available[tb_test_case];
      @(posedge tb_clk);
      if(tb_dependency_add != test_dependency_add[tb_test_case])
        $info("ERROR dependency_add not correct for test case %0d",tb_test_case);
	    if(tb_sram_address_store != test_sram_address_store[tb_test_case])
        $info("ERROR sram_address_store not correct for test case %0d",tb_test_case);
	    if(tb_sram_address_load != test_sram_address_load[tb_test_case])
        $info("ERROR sram_address_load not correct for test case %0d",tb_test_case);
	    if(tb_source1 != test_source1[tb_test_case])
        $info("ERROR source1 not correct for test case %0d",tb_test_case);
	    if(tb_source2 != test_source2[tb_test_case])
        $info("ERROR source2 not correct for test case %0d",tb_test_case);
	    if(tb_read_instruction1 != test_read_instruction1[tb_test_case])
        $info("ERROR read_instruction1[ not correct for test case %0d",tb_test_case);
	    if(tb_store2_enable != test_store2_enable[tb_test_case])
        $info("ERROR store2_enable not correct for test case %0d",tb_test_case);
	    if(tb_store1_enable != test_store1_enable[tb_test_case])
        $info("ERROR store1_enable not correct for test case %0d",tb_test_case);
	    if(tb_load_enable != test_load_enable[tb_test_case])
        $info("ERROR load_enable not correct for test case %0d",tb_test_case);
	    if(tb_add_enable != test_add_enable[tb_test_case])
        $info("ERROR add_enable not correct for test case %0d",tb_test_case);
	    if(tb_sub_enable != test_sub_enable[tb_test_case])
        $info("ERROR sub_enable not correct for test case %0d",tb_test_case);
	    if(tb_mul_enable != test_mul_enable[tb_test_case])
        $info("ERROR mul_enable not correct for test case %0d",tb_test_case);
	    if(tb_sin_enable != test_sin_enable[tb_test_case])
        $info("ERROR sin_enable not correct for test case %0d",tb_test_case);
	    if(tb_neg_enable != test_neg_enable[tb_test_case])
        $info("ERROR neg_enable not correct for test case %0d",tb_test_case);
	    if(tb_abs_enable != test_abs_enable[tb_test_case])
        $info("ERROR abs_enable not correct for test case %0d",tb_test_case);
	    if(tb_move_enable != test_move_enable[tb_test_case])
        $info("ERROR move_enable not correct for test case %0d",tb_test_case);
	    if(tb_add_dest != test_add_dest[tb_test_case])
        $info("ERROR add_dest not correct for test case %0d",tb_test_case);
	    if(tb_sub_dest != test_sub_dest[tb_test_case])
        $info("ERROR sub_dest not correct for test case %0d",tb_test_case);
	    if(tb_mul_dest != test_mul_dest[tb_test_case])
        $info("ERROR mul_dest not correct for test case %0d",tb_test_case);
	    if(tb_sin_dest != test_sin_dest[tb_test_case])
        $info("ERROR sin_dest not correct for test case %0d",tb_test_case);
	    if(tb_neg_dest != test_neg_dest[tb_test_case])
        $info("ERROR neg_dest not correct for test case %0d",tb_test_case);
	    if(tb_abs_dest != test_abs_dest[tb_test_case])
        $info("ERROR abs_dest not correct for test case %0d",tb_test_case);
	    if(tb_move_dest != test_move_dest[tb_test_case])
        $info("ERROR move_dest not correct for test case %0d",tb_test_case);
	    
	    end
	    
  end
  
  initial
  begin
    //first inital test case
    test_case_num = 1;
    test_instruction1[test_case_num] = 16'h0000;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    
    //2 perform store 2, store to sram from regester
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h1FAA;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'hAA;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hF;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //3 perform a load from sram to regesters but not ready
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h2855;
    test_dependency[test_case_num] = 16'h0100;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //4 try acual load with no dependency issue
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h2755;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0080;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h55;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //5 command the use of an add
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h30A4;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0001;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hA;
    test_source2[test_case_num] = 4'h4;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //6 perform a subtrcation to location 1
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h41A5;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0002;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hA;
    test_source2[test_case_num] = 4'h5;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 1;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //7 perform multiplication to dest 2
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h52FF;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0004;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hF;
    test_source2[test_case_num] = 4'hF;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 2;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //8 perform a sine with to 3
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h63A5;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0008;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hA;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 3;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //9  performa a negation to dest 4
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h7457;//trash value in the second adress
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0010;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h5;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 4;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //10 perform an absolution to dest 5
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h85AA;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0020;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hA;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 5;
    test_move_dest[test_case_num] = 0;
    //11 perofrom a move from D to 6
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h96D0;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0040;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'hD;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 6;
    //12 performa a store 1 
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hA550;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h55;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //13 atempt to use instruction 11
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hBEEF;
    test_dependency[test_case_num] = 16'hAAAA;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //14 test to use instruction12
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hCAB5;
    test_dependency[test_case_num] = 16'h5555;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //15 test use instruction 13
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hDEAD;
    test_dependency[test_case_num] = 16'hAAAA;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //16 test instruction 14
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hEEE0;
    test_dependency[test_case_num] = 16'hAAAA;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //17 test instruction 15
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hFEED;
    test_dependency[test_case_num] = 16'hAAAA;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 1;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //18 test to not perform add
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h3F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //19 test not perform a store 1 but not ready
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h1F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //20 not perform a sub
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h4F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //21 not perform a mul
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h5F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //22 do not perform an sin
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h6F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //23 do not perfrom a neg
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h7F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //24 do not perfrom an Abs
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h8F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //25 do not perform an Move
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h9F54;
    test_dependency[test_case_num] = 16'hFFFF;
    test_instruction_available[test_case_num]= 1;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    
    //copy of tests with fifo empty
    //26 
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h2755;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h0;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //27 command the use of an add
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h30A4;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //28 perform a subtrcation to location 1
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h41A5;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //29 perform multiplication to dest 2
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h52FF;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //30 perform a sine with to 3
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h63A5;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //31  performa a negation to dest 4
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h7457;//trash value in the second adress
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //32 perform an absolution to dest 5
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h85AA;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //33 perofrom a move from D to 6
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'h96D0;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //34 performa a store 1 
    test_case_num = test_case_num +1;
    test_instruction1[test_case_num] = 16'hA550;
    test_dependency[test_case_num] = 16'h0000;
    test_instruction_available[test_case_num]= 0;
    
    test_dependency_add[test_case_num] = 16'h0000;
    test_sram_address_store[test_case_num] = 8'h00;
    test_sram_address_load[test_case_num] = 8'h00;
    test_source1[test_case_num] = 4'h0;
    test_source2[test_case_num] = 4'h0;
  
    test_read_instruction1[test_case_num] = 0;
  
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
  
    test_add_dest[test_case_num] = 0;
    test_sub_dest[test_case_num] = 0;
    test_mul_dest[test_case_num] = 0;
    test_sin_dest[test_case_num] = 0;
    test_neg_dest[test_case_num] = 0;
    test_abs_dest[test_case_num] = 0;
    test_move_dest[test_case_num] = 0;
    //
    
    end
  
endmodule