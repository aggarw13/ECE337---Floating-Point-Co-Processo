// $Id: $
// File name:   tb_instruction_parser.sv
// Created:     4/28/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: A test bench for the instruction parser

`timescale 1ns / 10ps
module tb_instruction_parser();
  localparam NUM_TEST_CASES = 15;
  parameter CLK_PERIOD = 10;
  
  reg tb_clk;
  reg tb_n_rst;
  reg [31:0]tb_address_bus;
  reg [31:0]tb_data_bus;
  reg tb_read_instruction; //this is a read cycle
  reg tb_valid_data; //this instruction can be paid attention too
  reg [15:0]tb_dependency_remove;
  reg [31:0]tb_read_data_buff;
  reg tb_read_data_enable; // this should be tied to the store 1 enable 
  reg tb_instruction_buffer_full;
  
  reg [15:0]tb_instruction_out;
  reg tb_add_instruction;// conmmand to add the instruction to the fifo
  reg [3:0]tb_out_reg;//this is the regester to otput data to the master
  reg tb_read_error;
  reg tb_write_error;
  
  integer tb_test_case;
  integer test_case_num;
  
  reg [1:NUM_TEST_CASES][31:0]test_address_bus;
  reg [1:NUM_TEST_CASES][31:0]test_data_bus;
  reg [1:NUM_TEST_CASES]test_read_instruction; //this is a read cycle
  reg [1:NUM_TEST_CASES]test_valid_data; //this instruction can be paid attention too
  reg [1:NUM_TEST_CASES][15:0]test_dependency_remove;
  reg [1:NUM_TEST_CASES][31:0]test_read_data_buff;
  reg [1:NUM_TEST_CASES]test_read_data_enable; // this should be tied to the store 1 enable 
  reg [1:NUM_TEST_CASES]test_instruction_buffer_full;
  
  reg [1:NUM_TEST_CASES][15:0]test_instruction_out;
  reg [1:NUM_TEST_CASES]test_add_instruction;// conmmand to add the instruction to the fifo
  reg [1:NUM_TEST_CASES][3:0]test_out_reg;//this is the regester to otput data to the master
  reg [1:NUM_TEST_CASES]test_read_error;
  reg [1:NUM_TEST_CASES]test_write_error;
  
  instruction_parser DUT
  (
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .address_bus(tb_address_bus),
  .data_bus(tb_data_bus),
  .read_instruction(tb_read_instruction), //this is a read cycle
  .valid_data(tb_valid_data), //this in.can be paid attention too
  .dependency_remove(tb_dependency_remove),
  .read_data_buff(tb_read_data_buff),
  .read_data_enable(tb_read_data_enable), // this should be tied to the store 1 enable 
  .instruction_buffer_full(tb_instruction_buffer_full),
  
  .instruction_out(tb_instruction_out),
  .add_instruction(tb_add_instruction),// conmmand to add the instruction to the fifo
  .out_reg(tb_out_reg),//this is the regester to otput data to the master
  .read_error(tb_read_error),
  .write_error(tb_write_error)
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
	  tb_address_bus = '0;
	  tb_data_bus = '0;
	  tb_read_instruction= 0;
	  tb_valid_data = 0;
	  tb_dependency_remove = 0;
	  tb_read_data_enable=0;
	  tb_instruction_buffer_full =0;
	  
	  #0.2;
	  tb_n_rst = 1'b0;
	  #0.5;
	  tb_n_rst = 1'b1;
	  @(posedge tb_clk);
	  @(negedge tb_clk);
	  for(tb_test_case = 1; tb_test_case <= NUM_TEST_CASES; tb_test_case++)
	  begin
	     tb_address_bus = test_address_bus[tb_test_case];
	     tb_data_bus = test_data_bus[tb_test_case];
	     tb_read_instruction= test_read_instruction[tb_test_case];
	     tb_valid_data = test_valid_data[tb_test_case];
	     tb_dependency_remove = test_dependency_remove[tb_test_case];
	     tb_read_data_enable = test_read_data_enable[tb_test_case];
	     tb_instruction_buffer_full = test_instruction_buffer_full[tb_test_case];
	     //go to the next clk to check
	     @(posedge tb_clk);
	     //go a lot a way but 5ns
	     #2.5
	     if(tb_read_data_buff != test_read_data_buff[tb_test_case])
	      $info("ERROR: read_data_buff not correct for case %0d", tb_test_case);
	     if(tb_instruction_out != test_instruction_out[tb_test_case])
	      $info("ERROR: instruction_out not correct for case %0d", tb_test_case);
	     if(tb_out_reg != test_out_reg[tb_test_case])
	      $info("ERROR: out_reg not correct for case %0d", tb_test_case);
	     if(tb_read_error != test_read_error[tb_test_case])
	      $info("ERROR: read_error not correct for case %0d", tb_test_case);
	     if(tb_add_instruction != test_add_instruction[tb_test_case])
	      $info("ERROR: add_instruction not correct for case %0d", tb_test_case);
	     if(tb_write_error != test_write_error[tb_test_case])
	      $info("ERROR: write_error not correct for case %0d", tb_test_case);
	      @(negedge tb_clk);
	    end
	    end
	    
	 initial
	 begin 
	 //1 do nothing
	 test_case_num = 1;  
	 test_address_bus[test_case_num] = 32'h00000000;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 0; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h0000;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //2 put random values on the bus but no latching signal
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h12345678;
   test_data_bus[test_case_num] = 32'h9abcde0;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 0; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h1234;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h8;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //3 now add a latching signal see if it gets sent out
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h31231234;
   test_data_bus[test_case_num] = 32'h12345678;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h3123;
   test_add_instruction[test_case_num] = 1;
   test_out_reg[test_case_num] = 4'h4;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //4 send a read on the now invalid regester
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h00000001;
   test_data_bus[test_case_num] = 32'ha5a5a5a5;
   test_read_instruction[test_case_num] = 1; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h0000;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h1;
   test_read_error[test_case_num] =1;
   test_write_error[test_case_num] =0;
   
   //5 now remove the dependancy and try again
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h00000001;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 1; 
   test_valid_data[test_case_num] = 0; 
   test_dependency_remove[test_case_num] =16'h0002;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h0000;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h1;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //6 add in an address to the fifo
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'hA0000000;
   test_data_bus[test_case_num] = 32'h5A5A5A5A;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h5A5A5A5A;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'hA000;
   test_add_instruction[test_case_num] = 1;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //7 add in another instruction
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'hA1000000;
   test_data_bus[test_case_num] = 32'hA5A5A5A5;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h5a5a5a5a;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'hA100;
   test_add_instruction[test_case_num] = 1;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //8 try to fill the buffer
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'hAA000000;
   test_data_bus[test_case_num] = 32'hfdfdfdfd;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h5a5a5a5a;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'hAA00;
   test_add_instruction[test_case_num] = 1;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //9 get an error when the buffer is full
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'hAB000000;
   test_data_bus[test_case_num] = 32'hebebebeb;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h5a5a5a5a;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'hAB00;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =1;
   
   //10 now read off the data
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h00000000;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 0; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'hA5A5A5A5;
   test_read_data_enable[test_case_num] = 1;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h0000;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //11 read off another data chunk and try to add in a sub instruction
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h45210000;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'hfdfdfdfd;
   test_read_data_enable[test_case_num] = 1;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h4521;
   test_add_instruction[test_case_num] = 1;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //12 now the input buffer is magically full, do not add another instruction also read off last chunk of buffer
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h45210000;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 1;
   test_instruction_buffer_full[test_case_num] = 1 ; 
  
   test_instruction_out[test_case_num] = 16'h4521;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0; // no error, already handled by scheduler
   
   //13 try to use the regester in prev test
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h45210005;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 1; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 0;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h4521;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h5;
   test_read_error[test_case_num] =1;
   test_write_error[test_case_num] =0;
   
   //14now lets remove the dependency and place another on
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h5F210000;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 0; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0020;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 1;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h5F21;
   test_add_instruction[test_case_num] = 1;
   test_out_reg[test_case_num] = 4'h0;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   
   //15 now try the read again
   test_case_num = test_case_num + 1;  
	 test_address_bus[test_case_num] = 32'h45210005;
   test_data_bus[test_case_num] = 32'h00000000;
   test_read_instruction[test_case_num] = 1; 
   test_valid_data[test_case_num] = 1; 
   test_dependency_remove[test_case_num] =16'h0000;
   test_read_data_buff[test_case_num] =32'h00000000;
   test_read_data_enable[test_case_num] = 1;
   test_instruction_buffer_full[test_case_num] = 0 ; 
  
   test_instruction_out[test_case_num] = 16'h4521;
   test_add_instruction[test_case_num] = 0;
   test_out_reg[test_case_num] = 4'h5;
   test_read_error[test_case_num] =0;
   test_write_error[test_case_num] =0;
   end
	     
endmodule