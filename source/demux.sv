

module demux #(
  parameter NUM_BITS = 24
  )
(
  //input wire [31:0] op1,
  //input wire [31:0] op2,
  input wire [4:0] select,
  //output reg [31:0][NUM_BITS - 1 : 0] op1_o,
  //output reg [31:0][NUM_BITS - 1 : 0] op2_o
  input wire [NUM_BITS - 1 : 0][22:0] inputs,
  output reg [22:0] shifted_mantissa
  );
  integer i;
  /*
  always_comb begin 
    for(i = 0; i < 24; i++)  
    begin
        shifted_mantissa = (select == i) & inputs[i] | (select != i) & '0;
        //op1_o[i] = (select == i) & op1 | !(select == i) & '0;
        //op2_o[i] = (select == i) & op2 | !(select == i) &'0;
    end        
  end*/
  assign shifted_mantissa = inputs[select]; 
endmodule