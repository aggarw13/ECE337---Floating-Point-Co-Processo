//Input Interface Module for AMBA APB Slave
// Error cases
// 1) Write Error - Source : Data buffer or Input FIFO (Returns PLSVERROR)
// 2) Read Error - Source : Invalid Data due to dependencies or result-wait state (returns PSLVERROR depending on amount of instruction traffic)
 
module APB_slave_interface(
  input wire apb_clk,
  input wire clk,
  input wire npreset,
  input wire [31:0] paddr,
  input wire pselec1,
  input wire penable,
  input wire pwrite,
  input wire [31:0] pwdata,
  input wire [31:0] output_data,
  input wire read_error,
  input wire write_error, 
  output logic pready,
  output logic [31:0] prdata,
  output logic pslverr,
  output logic [31:0]address_bus,
  output logic [31:0]data_bus,
  output logic write_instr,
  output logic valid_data                                 // Singal to notify arrival of new valid instruction
  );
  
  logic rising_edge_detect;
  
  // States of AMBA Interface (is a STATE machine design) : IDLE STATE, SETUP PHASE, ACCESS PHASE 1, ACCESS PHASE 2, ERROR PHASE, INTERIM PHASE
  //IDLE STATE : Interface waits for the master to assert the select line to activate the Slave Processor
  //SETUP : Master asserts the slave select line to activate the Slave Processor and indicates a Read or Write Transfer with appropriate instruction in Address bus
  //ACCESS PHASE 1 : Slave reciprocates a Ready Signal and instrcuts the slave chip about valid new instruction with a pulse
  //ACCESS PHASE 2 : Slave assess the state of the chip to assess if it can service the request. If true, stores the instruction in FIFO
  //ERROR STATE : Signifies a busy FLoating oint Porcessor Slave for accepting any write instruction or Invalid Result for a Read Transfer Request
  
   
  apb_clk_detect DETECT_RISING_EDGE(.apb_clk(apb_clk), .system_clk(clk), .rising_edge_found(rising_edge_detect),.nrst(1'b1));
  typedef enum bit [2:0] {IDLE, SETUP, ACCESS_1, ACCESS_2, ERROR, INTERIM} amba_states;
  amba_states curr_state, next_state;
  assign address_bus = paddr;
  assign data_bus = pwdata;
  assign write_instr = pwrite;
  assign prdata = output_data;  
    
  always_ff @(posedge clk, negedge npreset) begin
    if(npreset == 1'b0)
      curr_state <= IDLE;
    else
      curr_state <= next_state;
  end
    
  always_comb begin : APB_NEXT_STATE
    next_state = curr_state;
    pslverr = 1'b0;
    pready = 1'b0;
    valid_data = 1'b0;
    case(curr_state)
      IDLE : begin
        if(rising_edge_detect && pselec1)
          next_state = SETUP;
        end
      SETUP : begin
        if(rising_edge_detect)
        begin   
          if(penable && !(write_error | read_error))
            next_state = ACCESS_1;
          else if(penable && write_error)
            next_state = ERROR;
          else if(!pselec1)
            next_state = IDLE;
          else
            next_state = ACCESS_1;
          end
        end
      ACCESS_1 : begin
        pready = 1'b1;
        valid_data = 1'b1;
        next_state = ACCESS_2;
      end
      ACCESS_2 : begin
        pready = 1'b1;
        if(read_error | write_error)
          next_state = ERROR;
        else if(rising_edge_detect)
          next_state = INTERIM;
        end
      INTERIM : begin
        if(pselec1)
          next_state = SETUP;
        else
          next_state = IDLE;
        end
      ERROR : begin
        pready = 1'b1;
        pslverr = 1'b1;
        if(rising_edge_detect)
          next_state = IDLE;
        end
      endcase
    end
endmodule
  
  
  
  
  
  
  
  
  