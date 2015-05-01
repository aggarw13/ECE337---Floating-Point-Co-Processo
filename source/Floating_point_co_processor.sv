// $Id: $
// File name:   Floating_point_co_processor.sv
// Created:     4/29/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: This is the large wrapper file for the project

module Floating_point_co_processor
#(
  parameter INSTRUCT_WIDTH = 16,
  parameter ALU_BLOCKS = 6 //number should update as number of blocks changes
  )  
(
  input wire clk,
  input wire n_rst
  //apb bus
);
  // wires needed for the instruction parser
  wire [INSTRUCT_WIDTH - 1:0]instruction;
  wire add_instruction;
  wire [15:0]drop_dependency;
  
  wire buffer_full;
  
  wire [7:0]sram_address_store;
  wire [7:0]sram_address_load;
  wire [3:0]source1;
  wire [3:0]source2;
  
  wire store2_enable;
  wire store1_enable;
  wire load_enable;
  wire add_enable;
  wire sub_enable;
  wire mul_enable;
  wire sin_enable;
  wire neg_enable;
  wire abs_enable;
  wire move_enable;
  
  wire [3:0]load_dest;
  wire [3:0]add_dest;
  wire [3:0]sub_dest;
  wire [3:0]mul_dest;
  wire [3:0]sin_dest;
  wire [3:0]neg_dest;
  wire [3:0]abs_dest;
  wire [3:0]move_dest;
  
  //wires needed from instruction parser
  wire [31:0]address_bus;
  wire[31:0]data_bus;
  
  wire read_instruction; 
  wire valid_data; 
  wire [31:0]read_data_buff;
  wire read_data_enable; 
  
  
  wire [3:0]out_reg;
  wire parse_read_error;
  wire parse_write_error;
  
  /*ALU wires*/
  //opperands 
  wire [31:0] opA;
  wire [31:0] opB;
  
  //dependency remove
  wire [ALU_BLOCKS-1:0][3:0]result_address;// inputs from the blocks
  wire [ALU_BLOCKS -1:0]remove_enable; //the enable of the remove dependecy
  
  //add block
  wire [3:0]add_result_addr;
  wire [31:0]add_result;
  wire add_result_done;
  
  //sub block
  wire [3:0]sub_result_addr;
  wire [31:0]sub_result;
  wire sub_result_done;
  
  //mul block
  wire [3:0]mul_result_addr;
  wire [31:0]mul_result;
  wire mul_result_done;
  
  //sin block
  wire [3:0]sin_result_addr;
  wire [31:0]sin_result;
  wire sin_result_done;
  
  //sram wires
  wire [7:0]sram_address;
  wire sram_store;
  wire [31:0] load_data; //this is the datapath from srram to regester
  wire [31:0] sram_write_data;
  wire [31:0] read_data // put data from regester to sram
  
  
  //this is the scheduler
  scheduler scheduler(
  .n_rst(n_rst),
  .clk(clk),
  .instruction(instruction),
  .add_instruction(add_instruction),
  .drop_dependency(drop_dependency),
  
  .buffer_full(buffer_full),
  
  .sram_address_store(sram_address_store),
  .sram_address_load(sram_address_load),
  .source1(source1),
  .source2(source2),
  
  .store2_enable(store2_enable),
  .store1_enable(store1_enable),
  .load_enable(load_enable),
  .add_enable(add_enable),
  .sub_enable(sub_enable),
  .mul_enable(mul_enable),
  .sin_enable(sin_enable),
  .neg_enable(neg_enable),
  .abs_enable(abs_enable),
  .move_enable(move_enable),
  
  .load_dest(load_dest),
  .add_dest(add_dest),
  .sub_dest(sub_dest),
  .mul_dest(mul_dest),
  .sin_dest(sin_dest),
  .neg_dest(neg_dest),
  .abs_dest(abs_dest),
  .move_dest(move_dest) 
  );
  
  //this is the instruction parser
  instruction_parser parser
  (
  .clk(clk),
  .n_rst(n_rst),
  .address_bus(address_bus),
  .data_bus(data_bus),
  .read_instruction(read_instruction), //this is a read cycle
  .valid_data(valid_data), //this in.can be paid attention too
  .dependency_remove(drop_dependency),
  .read_data_buff(read_data_buff),
  .read_data_enable(store1_enable), // this should be tied to the store 1 enable 
  .instruction_buffer_full(buffer_full),
  
  .instruction_out(instruction),
  .add_instruction(add_instruction),// conmmand to add the instruction to the fifo
  .out_reg(out_reg),//this is the regester to otput data to the master
  .read_error(parse_read_error),
  .write_error(parse_write_error)
  );
  
  /*ALU and other sub module blocks*/
  //dependancy remover
  dependency_remove //need to change i in this file if ALU_BLOCKS >8
  #(
  .NUM_BLOCKS(ALU_BLOCKS)
  )
   Dependency_remove
  (sram_address
    .result_address(result_address),
    .remove_enable(remove_enable),
    .dependency_remove(drop_dependency)
    );
    
  //ADD _block //block 0
  add_block ADD 
(
 .opA(opA),//first op
 .opB(opB),//secod op
 .clk(clk),//clk
 .nreset(n_rst),
 .result(add_result),//result
 .write_enable(add_result_done),//result done
 .dest_in(add_dest),//destination addr
 .reg_dest(add_result_addr),//output addr
 .new_instr(add_enable)//enable signal
  );
  assign result_address[0] = add_result_addr;
  assign remove_enable[0] = add_result_done;
  
    //SUB _block //block 1
  subtract_block SUB 
(
 .opA(opA),//first op
 .opB(opB),//secod op
 .clk(clk),//clk
 .nreset(n_rst),
 .result(sub_result),//result
 .write_enable(sub_result_done),//result done
 .dest_in(sub_dest),//destination addr
 .reg_dest(sub_result_addr),//output addr
 .new_instr(sub_enable)//enable signal
  );
  assign result_address[1] = sub_result_addr;
  assign remove_enable[1] = sub_result_done;
  
  //MUL block //block 2
  multiply MUL(
	 .clk(clk),
	 .nrst(n_rst),
	 .operand1(opA),
	 .operand2(opB),
	 .mulEna(mul_enable),
	 .in_dest(mul_dest),
	 .result(mul_result),
	 .done(mul_result_done),
	 .out_dest(mul_result_addr)
	);
  assign result_address[2] = mul_result_addr;
  assign remove_enable[2] = mul_result_done;
  
  //SIN block //block 3
  sine SIN
  (
    .operand(opA),
    .sineEna(sin_enable),
    .clk(clk),
    .nrst(n_rst),
    .in_dest(sin_dest),
    .result(sin_result),
    .done(sin_result_done),
    .out_dest(sin_result_addr)
  );
  assign result_address[3] = sin_result_addr;
  assign remove_enable[3] = sin_result_done;
  
  //state regester file
  StateMemory State_memory( 
  .w_sel0(add_result_addr), //write location
  .w_sel1(sub_result_addr),
  .w_sel2(mul_result_addr), 
  .w_sel3(sin_result_addr), 
  .w_sel4(tb_w_sel4), 
  .w_sel5(tb_w_sel5), 
  .w_en0(add_result_done), //write enable
  .w_en1(sub_result_done),
  .w_en2(mul_result_done), 
  .w_en3(sin_result_done), 
  .w_en4(tb_w_en4), 
  .w_en5(tb_w_en5), 
  .en_op1(1), 
  .en_op2(1), 
  .op1_sel(source1),
  .op2_sel(source2),
  .Result0(add_result), //write destination
  .Result1(sub_result), 
  .Result2(mul_result), 
  .Result3(sin_result), 
  .Result4(tb_Result4), 
  .Result5(tb_Result5), 
  .sram_r_en(tb_sram_r_en), //from regester to sram
  .sram_w_en(load_enable), //sram to regester enable
  .sram_r_sel(tb_sram_r_sel), //adress to read from 
  .sram_w_sel(load_dest), //address to wrtie to
  .write_data(load_data), 
  .op1(opA), 
  .op2(opB), 
  .read_data(read_data), 
  .Data_out(tb_Data_out), 
  .Data_out_sel(tb_Data_out_sel),
  .clk(clk),
  .nRst(n_rst)
  );
  
  //sram
  on_chip_sram_wrapper sram
	(
		// Test bench control signals
		.mem_clr(0),
		.mem_init(0),
		.mem_dump(0),
		.verbose(0),
		.init_file_number(0),
		.dump_file_number(0),
		.start_address(0),
		.last_address(0),
		// Memory interface signals
		.read_enable(load_enable),
		.write_enable(sram_store),
		.address(sram_address),
		.read_data(load_data),
		.write_data(sram_write_data)
	);
	assign sram_address =sram_address_store | sram_address_load; // this is to put it down to one line of addres
	assign sram_store = store2_enable | store1_enable; //makes it down to one bit
	assign sram_write_data = (store2_enable & read_data) | (store1_enable & read_data_buff); // compress the data down to one set of 32. might cause a problem
	
	
endmodule
