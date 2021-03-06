`timescale 1ns / 10ps

module tb_LODnbit();
parameter NUM_TEST_CASES = 6;
parameter DELAY = 5;
reg sign1;
reg sign2;
reg [23:0] op1;
reg [23:0] op2;
reg [23:0] count;
reg status;
reg [23:0] indicator;
wire [4:0] shift;

LOP_nbit count_shift(
  .op1(op1),
  .op2(op2),
  .shift(shift)
  );

//LOD zero_count(.result(indicator), .lzc(count), .status(status)); 

reg [1:NUM_TEST_CASES][23:0] opr1;
reg [1:NUM_TEST_CASES][23:0] opr2;
reg [1:NUM_TEST_CASES][2:0] test;
integer index;  
  
initial 
begin
//Using Test Vectors
//Test 1
test[1] = 1; 
opr1[1] = 24'h080000;
opr2[1] = 24'h180000;

//Test Case 2
test[2] = 2; 
opr1[2] = 24'h880000;
opr2[2] = 24'h080000;

//Test Case 3
test[3] = 3; 
opr1[3] = 24'h180000;
opr2[3] = 24'h080000;

//Test Case 4
test[4] = 4; 
opr1[4] = 24'h230000;
opr2[4] = 24'h280000;

//Test Case 5
test[5] = 5; 
opr1[5] = 24'h380000;
opr2[5] = 24'h080000;

//Test Case 6
test[6] = 6;
opr1[6] = 0;
opr2[6] = 0;
end

initial 
begin
  //op1 = 8'h08;
  //op2 = 8'h01;
  #(DELAY);
  for(index = 1; index <= NUM_TEST_CASES; index++)
  begin
    op1 = opr1[index];
    op2 = opr2[index];
    //indicator = opr1[index];
    //#(DELAY);
    //indicator = opr2[index];
    #(DELAY);
  end
end
endmodule