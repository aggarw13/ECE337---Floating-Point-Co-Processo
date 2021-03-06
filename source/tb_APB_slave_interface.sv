// Test Bench for AMBA Bus Inteface (Actually Test Bemch for then entire design)
`timescale 1ns / 10ps
module tb_APB_slave_interface();

localparam APB_CLK_PERIOD = 15;
localparam SYS_CLK_PERIOD = 5;
localparam NUM_TEST_CASES = 6;
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
reg [31:0] tb_output_data;
reg tb_write_error;
reg tb_read_error;
reg tb_pslverr;
reg tb_pready;
reg tb_new_instr;
reg tb_address_bus;
reg tb_data_bus;
reg tb_write_instr;
reg tb_valid_data;
//reg tb_rising_edge_detect;
integer i;

APB_slave_interface amba_slave (
  .apb_clk(tb_apb_clk),
  .clk(tb_clk),
  .npreset(tb_npreset),
  .paddr(tb_paddr),
  .pselec1(tb_pselec1),
  .penable(tb_penable),
  .pwrite(tb_pwrite),
  .pwdata(tb_pwdata),
  .output_data(tb_output_data),
  .read_error(tb_read_error),
  .write_error(tb_write_error),
  .pready(tb_pready),
  .prdata(tb_prdata),
  .pslverr(tb_pslverr),
  .address_bus(tb_address_bus),
  .data_bus(tb_data_bus),
  .valid_data(tb_valid_data)
  //.rising_edge_detect(tb_rising_edge_found)
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
reg [1:NUM_TEST_CASES] read_error;
reg [1:NUM_TEST_CASES] write_error;
reg [1:NUM_TEST_CASES] output_data;
reg [1:NUM_TEST_CASES] npreset;
reg [1:NUM_TEST_CASES] pselec1;

initial begin
  //Tect Case 1 : Simple Test with Store Instruction
  read_error[1] = 1'b0;
  write_error[1] = 1'b0;
  output_data[1] = '0;
  npreset[1] = 1'b1;
  pwrite[1] = 1'b1;
  pselec1[1] = 1'b1;
 
   //Tect Case 2 : Simple Test with Load Instruction
  read_error[2] = 1'b0;
  write_error[2] = 1'b0;
  output_data[2] = '0;
  npreset[2] = 1'b1;
  pwrite[2] = 1'b1;
  pselec1[2] = 1'b1;
  
  //Tect Case 3 : Simple Test without pselec
  read_error[3] = 1'b0;
  write_error[3] = 1'b0;
  output_data[3] = '0;
  npreset[3] = 1'b1;
  pwrite[3] = 1'b1;
  pselec1[3] = 1'b0;
  
   //Tect Case 4 : Simple Test with Write_error
  read_error[4] = 1'b0;
  write_error[4] = 1'b1;
  output_data[4] = '0;
  npreset[4] = 1'b1;
  pwrite[4] = 1'b1;
  pselec1[4] = 1'b1;
  
   //Tect Case 5 : Simple Test with Read Error
  read_error[5] = 1'b1;
  write_error[5] = 1'b0;
  output_data[5] = 32'hffffffff;
  npreset[5] = 1'b1;
  pwrite[5] = 1'b0;
  pselec1[5] = 1'b1;
  
  //Test Case 6 : Case with AMBA Bus Reset
  read_error[6] = 1'b0;
  write_error[6] = 1'b0;
  output_data[6] = 32'hffffffff;
  npreset[6] = 1'b0;
  pwrite[6] = 1'b1;
  pselec1[6] = 1'b1;
  
end

initial begin
  tb_pwdata = '0;
  tb_paddr = '0;
  @(negedge tb_apb_clk);
  for(i = 1; i <= NUM_TEST_CASES; i++) begin
    tb_penable = 1'b0;
    tb_npreset = npreset[i];
    tb_pwrite = pwrite[i];
    tb_pselec1 = pselec1[i];
    @(posedge tb_apb_clk);
    #(APB_CLK_PERIOD - DELAY);
    tb_penable = 1'b1;
    tb_write_error = write_error[i];
    @(posedge tb_apb_clk);
    tb_read_error = read_error[i];
    @(posedge tb_clk);
    @(posedge tb_apb_clk);
  end
end
  
endmodule   
