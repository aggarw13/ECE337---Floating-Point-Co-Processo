module LOD_nbit #(
  NUM_BITS = 4,
  COUNT_BITS = 2
  )
  (
  input wire status1,
  input wire status2,
  input wire [COUNT_BITS - 2:0] count1,
  input wire [COUNT_BITS - 2:0] count2,
  output wire [COUNT_BITS - 1 : 0] zcount,
  output wire status
  );   
    
  genvar i;
  assign status = status1 | status2;
  generate
     for(i = 0; i < COUNT_BITS; i++) begin
      if(i == COUNT_BITS - 1)
        assign zcount[i] = !status1;
      else 
        assign zcount[i] = (status1 == 1)? count1[i] : count2[i];
     end
   endgenerate
endmodule