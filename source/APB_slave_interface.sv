//Input Interface Module for AMBA APB Slave
// Error cases
// 1) Write Error - Source : Data buffer or Input FIFO (Can keep pready LOW or return PLSVERROR depedning on the situatioin of dependencies)
// 2) Read Error - Source : Invalid Data due todependencies or result-wait state (can keep PREADY LOW or return PSLVERROR depending on amount of instruction traffic)
 
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
  input wire write_error, //take care of buffer full error
  output logic pready,
  output logic [31:0] prdata,
  output logic pslverr,
  output logic [31:0]address_bus,
  output logic [31:0]data_bus,
  output logic write_instr,
  output logic valid_data                                 // Singal to notify arrival of new valid instruction
  );
  
  logic rising_edge_detect;
  // States of AMBA Interface (in a STATE machine design) : IDLE STATE, SETUP PHASE, WAIT STATE, ACCESS PHASE, ERROR PHASE 
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
            next_state = ACCESS;
          else if(penable && write_error)
            next_state = ERROR;
          else if(!pselec1)
            next_state = IDLE;
          else
            next_state = ACCESS;
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
      /*WAIT : begin
        pready = 1'b0;
        if(rising_edge_detect & !wait_sig)
          next_state = ACCESS;
        else if(rising_edge_detect && penable && slave_error)
          next_state = ERROR;
        end*/
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
  
  
  
  
  
  
  
  
  