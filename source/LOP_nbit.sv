module LOP_nbit #(
   NUM_BITS = 24
   )
  (
    input wire [NUM_BITS - 1 : 0] op1,
    input wire [NUM_BITS - 1 : 0] op2,
    input wire eop,
    output wire [4 : 0] shift
  );
  
  logic [4:0] lzcount; logic allz_status;

  //Block for Prediction of Leading One 
  reg [NUM_BITS - 1 : 0] prop, indicator, kill, gen, carry_in;
  //genvar i;
  integer i,in,j;
  reg pos_check;  
  
  LOD LZC(.result(indicator), .lzc(lzcount), .status(allz_status)); 
  
  /*generate  
  for(i = 0; i < NUM_BITS; i++) begin
      assign prop[i] = op1[i] ^ op2[i];
      assign kill[i] = !op1[i] & !op2[i];
      assign gen[i] = op1[i] & op2[i];
      assign indicator[i] = (i == 0)? (op1[i] | op2[i]) : prop[i] ^ !kill[i - 1];
    end
  endgenerate
  */
  
  //assign indicator = 8'b00100111;
  
  always_comb begin
    for(i = 0; i < NUM_BITS; i++) begin
      prop[i] = op1[i] ^ op2[i];
      kill[i] = !op1[i] & !op2[i];
      gen[i] = op1[i] & op2[i];
      //indicator[i] = (i == 0)? (op1[i] & op2[i]) : (prop[i] | gen[i - 1]); 
      carry_in[i] = (i == 0)? 1 : ((i == 1)? (op1[i] & op2[i] | (op1[i] | op2[i])) : gen[i - 1] | (!kill[i - 1] & !kill[i - 2])); 
      indicator[i] = (i == 0)? 1 : prop[i] ^ carry_in[i];  
    end
  end
  
 //Breaking down addition to effective operation
  //assign shift = (allz_status == 1)? lzcount : '0;        
  assign shift = eop? '0 : lzcount;
  endmodule
      
   
    
    
     