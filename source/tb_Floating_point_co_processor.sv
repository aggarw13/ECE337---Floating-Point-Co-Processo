//TestBench for the Top - Level FP Processor Module
module tb_Floating_point_co_processor();

localparam APB_CLK_PERIOD = 20;
localparam SYS_CLK_PERIOD = 5;
localparam NUM_TEST_CASES = 10;
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
integer i;

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
  .pslverr(tb_pslverr)
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

reg [1:NUM_TEST_CASES] pwrite;
reg [1:NUM_TEST_CASES] npreset;
reg [1:NUM_TEST_CASES] pselec1;
reg [1:NUM_TEST_CASES] [22 : 0] mantissa;
reg [1:NUM_TEST_CASES] [8 : 0] sign_exp;
reg [1:NUM_TEST_CASES] [3 : 0] opcode;
reg [1:NUM_TEST_CASES] [3 : 0] src1;
initial begin
  //Test Case 1 Simple Store Instruction
  tb_pwdata = 23'b00010000011100101010000;
  tb_paddr = 8'h01;
  npreset[1] = 1'b1;
  pwrite[1] = 1'b1;
  pselec1[1] = 1'b1;
end

 
  // Test 
  
endmodule
  
  