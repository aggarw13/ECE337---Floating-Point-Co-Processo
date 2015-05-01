module LOD_4bit(
  input wire [1:0] res1,
  input wire [1:0] res2,
  output logic status,
  output logic [1:0] count
  );   
  
  assign status = res1[1] | res2[1];
  assign count[1] = {(res1[1] & res1[0] | !res1[1] & res2[0]), !res1[1]};
   
  
  
endmodule