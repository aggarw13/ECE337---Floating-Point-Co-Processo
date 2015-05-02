//TestBench for the Top - Level FP Processor Module
`timescale 1ns / 10ps
module tb_Floating_point_co_processor();

localparam APB_CLK_PERIOD = 20;
localparam SYS_CLK_PERIOD = 5;
localparam NUM_TEST_CASES = 8;
localparam DELAY = 3;

reg tb_apb_clk;
reg tb_clk;
reg tb_npreset;
reg [31:0] tb_paddr;
reg tb_pselec1;
reg tb_penable;
reg tb_pwrite;
reg [31:0] tb_pwdata;
reg [31:0] tb_prdata;
reg tb_pslverr;
reg tb_pready;
reg tb_n_rst;

Floating_point_co_processor FP_SLAVE (
  .apb_clk(tb_apb_clk),
  .clk(tb_clk),
  .npreset(tb_npreset),
  .paddr(tb_paddr),
  .pselec1(tb_pselec1),
  .penable(tb_penable),
  .pwrite(tb_pwrite),
  .pwdata(tb_pwdata),
  .pready(tb_pready),
  .prdata(tb_prdata),
  .pslverr(tb_pslverr),
  .n_rst(tb_n_rst)
);


always begin
  tb_apb_clk = 1'b1;
  #(APB_CLK_PERIOD / 2);
  tb_apb_clk = 1'b0;
  #(APB_CLK_PERIOD / 2);
end

always begin
  tb_clk = 1'b1;
  #(SYS_CLK_PERIOD / 2);
  tb_clk = 1'b0;
  #(SYS_CLK_PERIOD / 2);
end

integer i;
integer slave_error, next_instruct;

reg [1:NUM_TEST_CASES] pwrite;
reg [1:NUM_TEST_CASES] npreset;
reg [1:NUM_TEST_CASES] pselec1;
reg [1:NUM_TEST_CASES] [22 : 0] mantissa;
reg [1:NUM_TEST_CASES] [8 : 0] sign_exp;
reg [1:NUM_TEST_CASES] [3 : 0] opcode;
reg [1:NUM_TEST_CASES] [3 : 0] src1;
reg [1:NUM_TEST_CASES] [7 : 0] sram_addr;
reg [1:NUM_TEST_CASES] [3 : 0] dest;
reg [1:NUM_TEST_CASES] [3 : 0] src2;

initial begin
  //Test Case 1 Simple Store 1 Instruction
  src1[1] = 4'h0; 
  src2[1] = 4'h0;
  dest[1] =  4'h0;
  opcode[1] = 4'ha;
  npreset[1] = 1'b1;
  pwrite[1] = 1'b1;
  pselec1[1] = 1'b1;
  sram_addr[1] = 8'h00;
  mantissa[1] = 23'b01001010101110111100111;
  sign_exp[1] = 9'b000101111;
  
  // Test Case 2 Simple Store 1 Instruction
  src1[2] = 4'h1; 
  src2[2] = 4'h1; 
  dest[2] =  4'h0;
  opcode[2] = 4'ha;
  npreset[2] = 1'b1;
  pwrite[2] = 1'b1;
  pselec1[2] = 1'b1;
  sram_addr[2] = 8'h01;
  mantissa[2] = 23'b01001010101110111100111;
  sign_exp[2] = 9'b000101111;
  
  //Test Case 3 Simple Load Instruction
  src1[3] = 4'h0; 
  dest[3] =  4'h0;
  opcode[3] = 4'h2;
  npreset[3] = 1'b1;
  pwrite[3] = 1'b1;
  pselec1[3] = 1'b1;
  sram_addr[3] = 8'h00;
  mantissa[3] = 23'b01001010101110111100111;
  sign_exp[3] = 9'b000101111;
  
  //Test Case 4 Simple Load Instruction
  src1[4] = 4'h0; 
  dest[4] =  4'h1;
  opcode[4] = 4'h2;
  npreset[4] = 1'b1;
  pwrite[4] = 1'b1;
  pselec1[4] = 1'b1;
  sram_addr[4] = 8'h01;
  mantissa[4] = 23'b01001010101110111100111;
  sign_exp[4] = 9'b000101111;
  
  //Test Case 5 Simple Add Instruction
  src1[5] = 4'h0; 
  src2[5] = 4'h1;
  dest[5] = 4'h2;
  opcode[5] = 4'h2;
  npreset[5] = 1'b1;
  pwrite[5] = 1'b1;
  pselec1[5] = 1'b1;
  sram_addr[5] = 8'h01;
  mantissa[5] = 23'b01001010101110111100111;
  sign_exp[5] = 9'b000101111;  
  
  //Test Case 6 Simple Read Instrcution
  src1[6] = 4'h2; 
  src2[6] = 4'h0;
  dest[6] = 4'h0;
  opcode[6] = 4'hb;
  npreset[6] = 1'b1;
  pwrite[6] = 1'b0;
  pselec1[6] = 1'b1;
  sram_addr[6] = 8'h01;
  mantissa[6] = 23'b01001010101110111100111;
  sign_exp[6] = 9'b000101111;  
  
  //Test Case 7 Simple Multiply Instruction
  src1[7] = 4'h0; 
  src2[7] = 4'h1;
  dest[7] =  4'h3;
  opcode[7] = 4'h5;
  npreset[7] = 1'b1;
  pwrite[7] = 1'b1;
  pselec1[7] = 1'b1;
  sram_addr[7] = 8'h01;
  mantissa[7] = 23'b01001010101110111100111;
  sign_exp[7] = 9'b000101111;
  
  //Test Case 8 Simple Multiplication Result Read
  src1[8] = 4'h3; 
  src2[8] = 4'h0;
  dest[8] =  4'h0;
  opcode[8] = 4'hb;
  npreset[8] = 1'b1;
  pwrite[8] = 1'b0;
  pselec1[8] = 1'b1;
  sram_addr[8] = 8'h01;
  mantissa[8] = 23'b01001010101110111100111;
  sign_exp[8] = 9'b000101111;
  
end

initial begin
  tb_npreset = 1'b0;
  next_instruct = 0;
  slave_error = 0;
  tb_n_rst =1'b1;
  #(DELAY);
  tb_pselec1 = 1'b0;
  tb_n_rst =1'b0;
  #(DELAY);
  @(negedge tb_apb_clk);
  tb_n_rst = 1'b1;
  tb_pselec1 = 1'b1;
  tb_pwdata = '0;
  for(i = 1; i <= NUM_TEST_CASES; i++) begin
    slave_error = 0;
    next_instruct = 0;
    tb_pwrite = pwrite[i];
    tb_npreset = npreset[i];
    tb_pwrite = pwrite[i];
    tb_pselec1 = pselec1[i];
    if(opcode[i] == 4'ha) begin
      tb_paddr = {opcode[i], sram_addr[i],'0};
      tb_pwdata = {sign_exp[i] ,mantissa[i]};
    end
    else if(opcode[i] == 4'h1) 
      tb_paddr = {opcode[i], sram_addr[i],dest[i], '0};
    else if(opcode[i] == 4'hb) 
      tb_paddr  = {src1[i],'0};
    else
      tb_paddr = {opcode[i], src1[i] ,src2[i], '0};
    
    @(posedge tb_apb_clk);
    //SETUP PHASE
    #(APB_CLK_PERIOD - DELAY);
    tb_penable = 1'b1;
    
    @(posedge tb_apb_clk);
    //ACCESS PHASE
    if(tb_pready == 1'b1)
      next_instruct = 1;
    if(tb_pslverr)
      slave_error = 1;
    @(posedge tb_apb_clk);
    tb_penable = 1'b0;
    tb_pselec1 = 1'b0;
    //NEXT PHASE
    //Case when slave error is signalled by SLave
    if(next_instruct && tb_pready == 1'b0 && slave_error)
      i--;
    #(DELAY);
  end
end
    
endmodule