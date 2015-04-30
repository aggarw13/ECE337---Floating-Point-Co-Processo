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
  
  //dependency remove
  wire [ALU_BLOCKS-1:0][3:0]result_address,// inputs from the blocks
  wire [ALU_BLOCKS -1:0]remove_enable, //the enable of the remove dependecy
  
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
  .read_data_enable(add_instruction), // this should be tied to the store 1 enable 
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
  NUM_BLOCKS = ALU_BLOCKS
  )
   Dependency_remove
  (
    .result_address(result_address),
    .remove_enable(remove_enable),
    .dependency_remove(drop_dependency)
    );
endmodule
