module LOD_2bit(
  input wire [1:0] res,
  output logic status,
  output logic count
  );   

  assign status = res[0] | res[1];
  assign count = !res[1];
   
endmodule