// $Id: $
// File name:   tb_dependancy_reg.sv
// Created:     4/17/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a unit test bench to test the dependancy regesters for the scheduler of an alu

`timescale 1ns / 10ps

module tb_dependancy_reg();
  localparam NUM_TEST_CASES = 7;
  parameter CLK_PERIOD = 5;
  parameter NUM_REG = 16;
  
  reg tb_clk;
  reg tb_n_rst;
  reg [NUM_REG -1:0]tb_dependency_set;
  reg [NUM_REG -1:0]tb_dependency_remove;
  reg [NUM_REG -1:0]tb_dependency_exists;
  
  integer tb_test_case;
  integer test_case_num;
  reg [1:NUM_TEST_CASES][NUM_REG -1:0]test_case_dependency_set;
  reg [1:NUM_TEST_CASES][NUM_REG -1:0]test_case_dependency_remove;
  reg [1:NUM_TEST_CASES][NUM_REG -1:0]test_case_dependency_exists;
  
  
  dependancy_reg DUT
  (
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .dependency_set(tb_dependency_set),
    .dependency_remove(tb_dependency_remove),
    .dependency_exists(tb_dependency_exists)
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
	  tb_dependency_set = '0;
	  tb_dependency_remove = '0;
	  #0.1
	  tb_n_rst = 1'b0;
	  #0.1
	  tb_n_rst = 1'b1;
	  @(posedge tb_clk);
	  for (tb_test_case = 1; tb_test_case <= NUM_TEST_CASES; tb_test_case++)
	  begin
	    @(negedge tb_clk);
	    tb_dependency_set = test_case_dependency_set[tb_test_case];
	    tb_dependency_remove = test_case_dependency_remove[tb_test_case];
	    @(posedge tb_clk);
	    #1
	    if (tb_dependency_exists != test_case_dependency_exists[tb_test_case])
	      $info("ERROR not correct for test case %0d",tb_test_case);
	   end
	   end
	   
	 
	  initial
	  begin
	    // basic write a zero test
	    test_case_num = 1;
	    test_case_dependency_set[test_case_num] = 16'h00;
	    test_case_dependency_remove[test_case_num] = 16'h00;
	    test_case_dependency_exists[test_case_num]= 16'h00;
	    
	    //add in a dependency 
	    test_case_num = test_case_num + 1;
	    test_case_dependency_set[test_case_num] = 16'hFFFF;
	    test_case_dependency_remove[test_case_num] = 16'h00;
	    test_case_dependency_exists[test_case_num]= 16'hFFFF;
	    
	    //remove dependency  
	    test_case_num = test_case_num + 1;
	    test_case_dependency_set[test_case_num] = 16'h00;
	    test_case_dependency_remove[test_case_num] = 16'hFFFF;
	    test_case_dependency_exists[test_case_num]= 16'h00;
	    
	    //remove dependency with no additional work  
	    test_case_num = test_case_num + 1;
	    test_case_dependency_set[test_case_num] = 16'h00;
	    test_case_dependency_remove[test_case_num] = 16'hFFFF;
	    test_case_dependency_exists[test_case_num]= 16'h00;
	    
	    //add dependency for next case 
	    test_case_num = test_case_num + 1;
	    test_case_dependency_set[test_case_num] = 16'hFFFF;
	    test_case_dependency_remove[test_case_num] = 16'h0000;
	    test_case_dependency_exists[test_case_num]= 16'hFFFF;
	    
	    //check add nd remove at the same time
	    test_case_num = test_case_num + 1;
	    test_case_dependency_set[test_case_num] = 16'hFFFF;
	    test_case_dependency_remove[test_case_num] = 16'hFFFF;
	    test_case_dependency_exists[test_case_num]= 16'h00;
	    
	    //remove dependency  
	    test_case_num = test_case_num + 1;
	    test_case_dependency_set[test_case_num] = 16'h00;
	    test_case_dependency_remove[test_case_num] = 16'h0000;
	    test_case_dependency_exists[test_case_num]= 16'hFFFF;
	    
	  end
	    
endmodule