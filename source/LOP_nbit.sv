//Description : Leadiing One Anticipator/Predictor for estimating the left shift required for normalization of Mantissa Addition Result

module LOP_nbit #(
   NUM_BITS = 24
   )
  (
    input wire [NUM_BITS - 1 : 0] op1,
    input wire [NUM_BITS - 1 : 0] op2,
    input wire eop,
    output wire [4 : 0] shift
  );
  
  logic [4:0] lzcount; 

  //Block for Prediction of Leading One 
  reg [NUM_BITS - 1 : 0] prop, indicator, kill, gen, carry_in;
  integer i;
  reg pos_check;  
  
  //Instantiating LOD module for counting he leading-zeros from anticipitated addition result
  LOD LZC(.result(indicator), .lzc(lzcount)); 

  //Predicting the Operand Mantissa Addition (using algorithm from Karnaugh Map Optimized Formula from IEEE Research paper)
  always_comb begin
    for(i = 0; i < NUM_BITS; i++) begin
      prop[i] = op1[i] ^ op2[i];
      kill[i] = !op1[i] & !op2[i];
      gen[i] = op1[i] & op2[i];
      carry_in[i] = (i == 0)? 1 : ((i == 1)? (op1[i] & op2[i] | (op1[i] | op2[i])) : gen[i - 1] | (!kill[i - 1] & !kill[i - 2])); 
      indicator[i] = (i == 0)? 1 : prop[i] ^ carry_in[i];  
    end
  end
        
  assign shift = eop? '0 : lzcount;
  endmodule
      
   
    
    
     