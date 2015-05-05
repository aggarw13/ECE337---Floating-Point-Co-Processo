//TestBench for the Top - Level FP Processor Module
`timescale 1ns / 10ps
module tb_Floating_point_co_processor();

localparam APB_CLK_PERIOD = 28;
localparam SYS_CLK_PERIOD = 7;
localparam NUM_TEST_CASES = 20;
localparam DELAY = 10;
localparam SELEC_DELAY = 13;

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

Floating_point_co_processor_top FP_SLAVE (
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
  sram_addr[1] = 8'h01;
  mantissa[1] = 23'b11001010101110111100111;
  sign_exp[1] = 9'b011101111;
  
  // Test Case 2 Simple Store 1 Instruction
  src1[2] = 4'h1; 
  src2[2] = 4'h1; 
  dest[2] =  4'h0;
  opcode[2] = 4'ha;
  npreset[2] = 1'b1;
  pwrite[2] = 1'b1;
  pselec1[2] = 1'b1;
  sram_addr[2] = 8'h02;
  mantissa[2] = 23'b01011011101110111100111;
  sign_exp[2] = 9'b000011111;
  
  //Test Case 3 Simple Load Instruction
  src1[3] = 4'h0; 
  dest[3] =  4'h1;
  opcode[3] = 4'h2;
  npreset[3] = 1'b1;
  pwrite[3] = 1'b1;
  pselec1[3] = 1'b1;
  sram_addr[3] = 8'h01;
  mantissa[3] = 23'b01001010101110111100111;
  sign_exp[3] = 9'b000101111;
  
  //Test Case 4 Simple Load Instruction
  src1[4] = 4'h0; 
  dest[4] =  4'hf;
  opcode[4] = 4'h2;
  npreset[4] = 1'b1;
  pwrite[4] = 1'b1;
  pselec1[4] = 1'b1;
  sram_addr[4] = 8'h02;
  mantissa[4] = 23'b01001010101110111100111;
  sign_exp[4] = 9'b000101111;
  
  //Test Case 5 Simple Add Instruction
  src1[5] = 4'hF; 
  src2[5] = 4'h1;
  dest[5] = 4'h2;
  opcode[5] = 4'h3;
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
  src1[7] = 4'hF; 
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
  
  //Test Case 9 Simple Sine Calculation
  src1[9] = 4'h2; 
  src2[9] = 4'h0;
  dest[9] =  4'h4;
  opcode[9] = 4'h6;
  npreset[9] = 1'b1;
  pwrite[9] = 1'b1;
  pselec1[9] = 1'b1;
  sram_addr[9] = 8'h00;
  mantissa[9] = 23'b01001010101110111100111;
  sign_exp[9] = 9'b000101111;
  
  //Test Case 10 Simple Calculated Sine Value Read (will be sent multiple times till Valid sine value is sent back)
  src1[10] = 4'h4; 
  src2[10] = 4'h0;
  dest[10] =  4'h0;
  opcode[10] = 4'hb;
  npreset[10] = 1'b1;
  pwrite[10] = 1'b0;
  pselec1[10] = 1'b1;
  sram_addr[10] = 8'h01;
  mantissa[10] = 23'b01001010101110111100111;
  sign_exp[10] = 9'b000101111;
  
  //Test Case 11 Simple Subtract Instruction
  src1[11] = 4'h2; 
  src2[11] = 4'h4;
  dest[11] =  4'h5;
  opcode[11] = 4'h4;
  npreset[11] = 1'b1;
  pwrite[11] = 1'b1;
  pselec1[11] = 1'b1;
  sram_addr[11] = 8'h01;
  mantissa[11] = 23'b01001010101110111100111;
  sign_exp[11] = 9'b000101111;
  
  //Test Case 12 Move Sine Result to Another Location
  src1[12] = 4'h5; 
  src2[12] = 4'h0;
  dest[12] =  4'h7;
  opcode[12] = 4'h9;
  npreset[12] = 1'b1;
  pwrite[12] = 1'b1;
  pselec1[12] = 1'b1;
  sram_addr[12] = 8'h03;
  mantissa[12] = 23'b01001010101110111100111;
  sign_exp[12] = 9'b000101111;
  
  //Test Case 13 Simple Absolution Instruction for Testing Dependency 
  src1[13] = 4'h5; 
  src2[13] = 4'h0;
  dest[13] =  4'h6;
  opcode[13] = 4'h8;
  npreset[13] = 1'b1;
  pwrite[13] = 1'b1;
  pselec1[13] = 1'b1;
  sram_addr[13] = 8'h01;
  mantissa[13] = 23'b01001010101110111100111;
  sign_exp[13] = 9'b000101111;
  
  //Test Case 14 Read Sine Result BackUp
  src1[14] = 4'h8; 
  src2[14] = 4'h0;
  dest[14] =  4'h0;
  opcode[14] = 4'h1;
  npreset[14] = 1'b1;
  pwrite[14] = 1'b1;
  pselec1[14] = 1'b1;
  sram_addr[14] = 8'h03;
  mantissa[14] = 23'b01001010101110111100111;
  sign_exp[14] = 9'b000101111;
  
  ///Error Test Cases (Filling Data Buffer) (for negative operand)
  src1[15] = 4'h8; 
  src2[15] = 4'h0;
  dest[15] =  4'h0;
  opcode[15] = 4'ha;
  npreset[15] = 1'b1;
  pwrite[15] = 1'b1;
  pselec1[15] = 1'b1;
  sram_addr[15] = 8'h04;
  mantissa[15] = 23'b11011010111110011110000;
  sign_exp[15] = 9'b111001111;
  
  //Test Case 16: Another Store 1 Instruction (for negative operand)
  src1[16] = 4'h8; 
  src2[16] = 4'h0;
  dest[16] =  4'h0;
  opcode[16] = 4'ha;
  npreset[16] = 1'b1;
  pwrite[16] = 1'b1;
  pselec1[16] = 1'b1;
  sram_addr[16] = 8'h05;
  mantissa[16] = 23'b01111010101110111100111;
  sign_exp[16] = 9'b110101111;
 
  //Test Case 17:  Load Instruction for negative operand 1
  src1[17] = 4'h8; 
  src2[17] = 4'h0;
  dest[17] =  4'h8;
  opcode[17] = 4'h2;
  npreset[17] = 1'b1;
  pwrite[17] = 1'b1;
  pselec1[17] = 1'b1;
  sram_addr[17] = 8'h04;
  mantissa[17] = 23'b01111010101110111100111;
  sign_exp[17] = 9'b110101111;
  
  //Test Case 18 : Negation test
  src1[18] = 4'h8; 
  src2[18] = 4'h0;
  dest[18] =  4'h8;
  opcode[18] = 4'h7;
  npreset[18] = 1'b1;
  pwrite[18] = 1'b1;
  pselec1[18] = 1'b1;
  sram_addr[18] = 8'h06;
  mantissa[18] = 23'b11001010111110011110000;
  sign_exp[18] = 9'b111001111;
  
   //Test Case 19:  Load Instruction for negative operand 2
  src1[19] = 4'h8; 
  src2[19] = 4'h9;
  dest[19] =  4'h9;
  opcode[19] = 4'h2;
  npreset[19] = 1'b1;
  pwrite[19] = 1'b1;
  pselec1[19] = 1'b1;
  sram_addr[19] = 8'h05;
  mantissa[19] = 23'b11001010111110011110000;
  sign_exp[19] = 9'b111001111;
  
  
  //Test Case 20 : Subtract Instructions for Different Signed operations (to obtain positive result)
  src1[20] = 4'h8; 
  src2[20] = 4'h9;
  dest[20] =  4'ha;
  opcode[20] = 4'h4;
  npreset[20] = 1'b1;
  pwrite[20] = 1'b1;
  pselec1[20] = 1'b1;
  sram_addr[20] = 8'hAA;
  mantissa[20] = 23'b11001010111110011110000;
  sign_exp[20] = 9'b111001111;
   
  
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
    #(SELEC_DELAY);
    slave_error = 0;
    next_instruct = 0;
    tb_pwrite = pwrite[i];
    tb_npreset = npreset[i];
    tb_pwrite = pwrite[i];
    tb_pselec1 = pselec1[i];
    if(opcode[i] == 4'ha) begin //Store 1 
      tb_paddr = {opcode[i],sram_addr[i],20'b0};
      tb_pwdata = {sign_exp[i] ,mantissa[i]};
    end
    else if(opcode[i] == 4'h2) //Load 
      tb_paddr = {opcode[i],dest[i],sram_addr[i],16'b0};
    else if(opcode[i] == 4'hb) //NOP for Reading
      tb_paddr  = {20'b0, src1[i]};
    else if(opcode[i] == 4'h1) // Store 2 
      tb_paddr = {opcode[i], src1[i], sram_addr[i], 16'b0}; 
    else
      tb_paddr = {opcode[i], dest[i], src1[i] ,src2[i], 16'b0};
    
    @(posedge tb_apb_clk);
    //SETUP PHASE
    #(APB_CLK_PERIOD - DELAY);
    tb_penable = 1'b1;
    
    @(posedge tb_apb_clk);
    @(posedge tb_apb_clk);
    //ACCESS PHASE
    if(tb_pready == 1'b1)
      next_instruct = 1;
    if(tb_pslverr)
      slave_error = 1;
    #(DELAY);
    tb_penable = 1'b0;
    tb_pselec1 = 1'b0;
    
    //NEXT PHASE
    //Case when slave error is signalled by SLave
    if(next_instruct && tb_pready == 1'b0 && slave_error)
      i--;
  end
end
    
endmodule