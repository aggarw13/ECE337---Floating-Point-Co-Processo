// $Id: $
// File name:   instruction_parser.sv
// Created:     4/26/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a Preprocessing of instructions before they go to the scheduling logic

module instruction_parser
  #(
  parameter t = 0
  )
  (
  input wire clk,
  input wire n_rst,
  input wire [31:0]address_bus,
  input wire[31:0]data_bus,
  input wire write_instruction, //this is the read write indicato
  input wire valid_data, //this instruction can be paid attention too
  input wire [15:0]dependency_remove,
  output wire [31:0]read_data_buff,
  input wire read_data_enable, // this should be tied to the store 1 enable 
  input wire instruction_buffer_full,
  
  output wire [15:0]instruction_out,
  output reg add_instruction,// conmmand to add the instruction to the fifo
  output wire [3:0]out_reg,//this is the regester to otput data to the master
  output reg read_error,
  output reg write_error
  );
  typedef enum bit[3:0] {STORE1=4'hA, STORE2=4'h1, LOAD=4'h2,ADD=4'h3, SUB=4'h4, //enumerateed types of different opcodes
                          MUL=4'h5, SIN=4'h6, NEG=4'h7, ABS=4'h8, MOVE=4'h9, NOP=4'h0} opcode_type;
  opcode_type opcode;// this is the iternal opcode to deal with 
  wire [3:0]dest; // this is the destination regester
  genvar i;
  
  reg [15:0]cnt_up;
  wire [15:0][3:0]count;
  reg prev_fifo;
  wire write_state;
  
  wire fifo_full;
  
  reg add_data; //this adds data to the data buffer
  
  assign instruction_out = address_bus[31:16]; //strip out the head to pass to the result regester
  assign out_reg = address_bus[3:0]; //this is the value to push to the output fifo
  assign opcode = opcode_type'(address_bus[31:28]);// pull off the opcode
  assign dest = address_bus[27:24];
  assign add_instruction = valid_data & write_instruction & !instruction_buffer_full & !write_error; // this is when to add the value to the input fifo
  assign write_state = valid_data & write_instruction & !instruction_buffer_full; // this is when to evaluate new data
  generate 
      for (i = 0;i <16; i= i+1) //make 16 updown counters to keep track of all dependant values
      begin
        upDownCounter IX
        (
          .clk(clk),
          .n_rst(n_rst),
          .up(cnt_up[i]),
          .down(dependency_remove[i]), // this is the signal from alu that istruction is finished
          .count_out(count[i]) 
        );
      end
  endgenerate
  
  //the buffer that is used to hold the input data
  flex_fifo 
  #(
    .WIDTH(32),
    .DEPTH(4),
    .BITS_WIDTH(5),
    .BITS_DEPTH(2)
    )
  Data_buffer
    (
      .clk(clk),
      .n_rst(n_rst),
      .r_enable(read_data_enable),
      
      .w_enable(add_data),
      .w_data(data_bus),
      
      .r_data(read_data_buff),
      .full(fifo_full),
      .empty()
    );
  always_ff @(posedge clk, negedge n_rst)
  begin
    if (n_rst ==0)
      prev_fifo <=0;
      else
        prev_fifo <= fifo_full;
    end
    
  always_comb
  begin
    add_data = 0;
    cnt_up = '0;
    write_error = 0;
    read_error =0;
    if(write_state)
      begin
        if (opcode == STORE1)
          begin
          add_data = 1;
          if (fifo_full & prev_fifo)
            write_error = 1;
          end
        
        if (opcode == LOAD || // these are the instructions that have destinations
            opcode == ADD  || 
            opcode == SUB  ||
            opcode == MUL  ||
            opcode == SIN  ||
            opcode == NEG  ||
            opcode == ABS  ||
            opcode == MOVE )
            begin
              cnt_up[dest] = 1;
            end
      end    
    if(!write_instruction &&  count[out_reg] != 0)
      read_error = 1;
  

  end
    
  
  
      
endmodule