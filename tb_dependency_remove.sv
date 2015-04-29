// $Id: $
// File name:   tb_dependency_remove.sv
// Created:     4/23/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a test bench for dependency remove

`timescale 1ns / 10ps

module tb_dependency_remove();
  localparam NUM_TEST_CASES = 9;
  parameter CLK_PERIOD = 5;
  parameter NUM_BLOCKS = 6;
  
  reg tb_clk;
  reg [NUM_BLOCKS-1:0][3:0]tb_result_address;
  reg [NUM_BLOCKS -1:0]tb_remove_enable;
  reg [15:0]tb_dependency_remove;
  
  integer tb_test_case;
  integer test_case_num;
  
  reg [1:NUM_TEST_CASES][NUM_BLOCKS-1:0][3:0]test_result_address;
  reg [1:NUM_TEST_CASES][NUM_BLOCKS -1:0]test_remove_enable;
  reg [1:NUM_TEST_CASES][15:0]test_dependency_remove;
  
  dependency_remove DUT
  (
    .result_address(tb_result_address),
    .remove_enable(tb_remove_enable),
    .dependency_remove(tb_dependency_remove)
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
	  tb_result_address = '0;
	  tb_remove_enable = '0;
	  @(posedge tb_clk);
	  for (tb_test_case = 1; tb_test_case <= NUM_TEST_CASES; tb_test_case++)
	  begin
	    @(negedge tb_clk);
	    tb_result_address = test_result_address[tb_test_case];
	    tb_remove_enable = test_remove_enable[tb_test_case];
	    @(posedge tb_clk);
	    #1
	    if (tb_dependency_remove != test_dependency_remove[tb_test_case])
	      $info("ERROR not correct for test case %0d",tb_test_case);
	   end
	   end
	   
	 initial
	 begin
	   //this is data but no data done
	   test_case_num = 1;
	   test_result_address[test_case_num][0] = 4'hA;
	   test_result_address[test_case_num][1] = 4'h5;
	   test_result_address[test_case_num][2] = 4'hA;
	   test_result_address[test_case_num][3] = 4'h5;
	   test_result_address[test_case_num][4] = 4'hA;
	   test_result_address[test_case_num][5] = 4'h5;
	   test_remove_enable[test_case_num] = 6'b000000;
	   test_dependency_remove[test_case_num] = 16'h0000;
	   //2 block 0 is done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b000001;
	   test_dependency_remove[test_case_num] = 16'h0020;
	   //3 block 1 is done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b000010;
	   test_dependency_remove[test_case_num]= 16'h0400;
	   //4 block 2 is done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b000100;
	   test_dependency_remove[test_case_num] = 16'h0020;
	   //5 block 3 is done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b001000;
	   test_dependency_remove[test_case_num] = 16'h0400;
	   //6 block 4 is done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b010000;
	   test_dependency_remove[test_case_num] = 16'h0020;
	   //7 block 5 is done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b100000;
	   test_dependency_remove[test_case_num] = 16'h0400;
	   //8 block 5 and 0 are done
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h5;
	   test_result_address[test_case_num][1] = 4'hA;
	   test_result_address[test_case_num][2] = 4'h5;
	   test_result_address[test_case_num][3] = 4'hA;
	   test_result_address[test_case_num][4] = 4'h5;
	   test_result_address[test_case_num][5] = 4'hA;
	   test_remove_enable[test_case_num] = 6'b100001;
	   test_dependency_remove[test_case_num] = 16'h0420;
	   //9 all blocks finish at once
	   test_case_num = test_case_num + 1;
	   test_result_address[test_case_num][0] = 4'h0;
	   test_result_address[test_case_num][1] = 4'h1;
	   test_result_address[test_case_num][2] = 4'h2;
	   test_result_address[test_case_num][3] = 4'h3;
	   test_result_address[test_case_num][4] = 4'h4;
	   test_result_address[test_case_num][5] = 4'h5;
	   test_remove_enable[test_case_num] = 6'b111111;
	   test_dependency_remove[test_case_num] = 16'h003F;
	 end
	   
endmodule
	 