// $Id: $
// File name:   scheduling_logic.sv
// Created:     4/7/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: The core of the sceduling logic. Used to give command to other parts of teh controller and determine when things may be preformed
//`define DESTINATION  instruction[11:8]
module scheduling_logic
(
  input wire [15:0]instruction1,
 //input wire [15:0]instruction2, // this is left for future development
  input wire [15:0]dependency,
  input wire instruction_available,
  
  output reg [15:0]dependency_add,
  output reg [7:0]sram_address_store,
  output reg [7:0]sram_address_load,
  output reg [3:0]source1,
  output reg [3:0]source2,
  
  output reg read_instruction1,
  
  output reg store2_enable,
  output reg store1_enable,
  output reg load_enable,
  output reg add_enable,
  output reg sub_enable,
  output reg mul_enable,
  output reg sin_enable,
  output reg neg_enable,
  output reg abs_enable,
  output reg move_enable,
  
  output reg [3:0]load_dest,
  output reg [3:0]add_dest,
  output reg [3:0]sub_dest,
  output reg [3:0]mul_dest,
  output reg [3:0]sin_dest,
  output reg [3:0]neg_dest,
  output reg [3:0]abs_dest,
  output reg [3:0]move_dest
    
);
  typedef enum bit[3:0] {STORE1=4'hA, STORE2=4'h1, LOAD=4'h2,ADD=4'h3, SUB=4'h4, //enumerateed types of different opcodes
                          MUL=4'h5, SIN=4'h6, NEG=4'h7, ABS=4'h8, MOVE=4'h9, NOP=4'h0} opcode_type;
  opcode_type opcode1;
  always_comb
  begin
    opcode1 = opcode_type'(instruction1[15:12]);// set the opcode as the opcode from the instruction
    //set the default values for the logic
    dependency_add = 16'h0000;
    sram_address_store = 8'h00;
    sram_address_load = 8'h00;
    source1 = 4'h0;
    source2 = 4'h0;
    read_instruction1 = 1;
    store2_enable = 0;
    store1_enable = 0;
    load_enable = 0;
    add_enable = 0;
    sub_enable = 0;
    mul_enable = 0;
    sin_enable = 0;
    neg_enable = 0;
    abs_enable = 0;
    move_enable = 0;
    
    load_dest =4'h0;
    add_dest = 4'h0;
    sub_dest = 4'h0;
    mul_dest = 4'h0;
    sin_dest = 4'h0;
    neg_dest = 4'h0;
    abs_dest = 4'h0;
    move_dest = 4'h0;
    
    if(instruction_available)
      begin
      if (opcode1==STORE1)
        begin
          sram_address_store= instruction1[11:4]; // get sram address from the input instruction
          store1_enable = 1;
          //undefined command to the sram block
          //other commands
          read_instruction1 = 1;
        end
      
      if (opcode1 == STORE2)begin
            if(! dependency[instruction1[11:8]])
            begin
              sram_address_store = instruction1[7:0]; //give this value to the sram
              source1 = instruction1[11:8]; //give this value to the regesters
              store2_enable = 1;
              //undefinded control comands
              read_instruction1 = 1; 
            end
          else
            read_instruction1 = 0;
      end
          
      if (opcode1 == LOAD)begin
        if(! dependency[instruction1[11:8]])
        begin
          load_enable = 1;
          dependency_add[instruction1[11:8]] = 1; //put this value on dependency list
          sram_address_load = instruction1[7:0]; //give this value to the sram
          read_instruction1 = 1;
          load_dest = instruction1[11:8];//totally forgot this
        end
      else
        read_instruction1 = 0;
      end
      
      if (opcode1 == ADD)begin
        if(! dependency[instruction1[11:8]] && ! dependency[instruction1[7:4]] && ! dependency[instruction1[3:0]])
        begin
          add_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          source1 = instruction1[7:4];
          source2 = instruction1[3:0];
          add_dest = instruction1[11:8];
          read_instruction1 = 1;
        end
        else
          read_instruction1 = 0;
      end
      
      if (opcode1 == SUB )begin
        if(! dependency[instruction1[11:8]] && ! dependency[instruction1[7:4]] && ! dependency[instruction1[3:0]])
        begin
          sub_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          sub_dest = instruction1[11:8];
          source1 = instruction1[7:4];
          source2 = instruction1[3:0];
          read_instruction1 = 1;
        end
        else
          read_instruction1 = 0;
      end
       
      if (opcode1 == MUL )begin
        if( ! dependency[instruction1[11:8]] && ! dependency[instruction1[7:4]] && ! dependency[instruction1[3:0]])
        begin
          mul_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          mul_dest= instruction1[11:8];
          source1 = instruction1[7:4];
          source2 = instruction1[3:0];
          read_instruction1 = 1;
        end
        else
          read_instruction1 = 0;
      end
        
      if (opcode1 == SIN )begin
        if( ! dependency[instruction1[11:8]] && !dependency[instruction1[7:4]])
        begin
          sin_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          source1 = instruction1[7:4];
          sin_dest = instruction1[11:8];
          read_instruction1 = 1;
        end
        else
          read_instruction1 = 0;
      end
        
      if (opcode1 == NEG)begin
        if( ! dependency[instruction1[11:8]] && !dependency[instruction1[7:4]])
        begin
          neg_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          source1 = instruction1[7:4];
          neg_dest = instruction1[11:8];
           read_instruction1 = 1;
         end
        else
          read_instruction1 = 0;
      end
      
      if (opcode1 == ABS )begin
        if(! dependency[instruction1[11:8]] && !dependency[instruction1[7:4]])
        begin
          abs_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          source1 = instruction1[7:4];
          abs_dest = instruction1[11:8];
          read_instruction1 = 1;
        end
        else
          read_instruction1 = 0;
      end
        
      if (opcode1 == MOVE)begin
        if( ! dependency[instruction1[11:8]] && !dependency[instruction1[7:4]])
        begin
          move_enable = 1;
          dependency_add[instruction1[11:8]] = 1;
          source1 = instruction1[7:4];
          move_dest = instruction1[11:8];
          read_instruction1 = 1;
         end
        else
          read_instruction1 = 0;
      end
      
    end
    else
      read_instruction1 = 0; //dont read if no data is available
      
  end
    
  
  
  
endmodule