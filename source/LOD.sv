module LOD #(
  NUM_BITS = 24,
  BIT_COUNT = 5
  )
  (
  input wire [NUM_BITS - 1 : 0] result,
  output logic [BIT_COUNT - 1 : 0] lzc,
  output logic status
  );   
  
  
  logic bit2_c1, bit2_c2, bit2_c3, bit2_c4, bit2_c5, bit2_c6, bit2_c7, bit2_c8, bit2_c9, bit2_c10, bit2_c11, bit2_c12; 
  logic bit2_s1, bit2_s2, bit2_s3, bit2_s4, bit2_s5, bit2_s6, bit2_s7, bit2_s8, bit2_s9, bit2_s10, bit2_s11, bit2_s12 ;
  logic [1:0] bit4_c1, bit4_c2, bit4_c3, bit4_c4, bit4_c5, bit4_c6;
  logic bit4_s1, bit4_s2, bit4_s3, bit4_s4, bit4_s5, bit4_s6;
  logic [2:0] bit8_c1, bit8_c2, bit8_c3;
  logic bit8_s1, bit8_s2, bit8_s3;
  logic [3:0] bit16_c1, bit16_c2;
  logic bit16_s1; 
  logic [1:12][1:0] lod_l1;
  logic [4:0] shift;
  assign lod_l1= {{result[23], result[22]}, {result[21], result[20]}, {result[19], result[18]}, {result[17], result[16]},
   {result[15], result[14]}, {result[13], result[12]},{result[11], result[10]},
    {result[9], result[8]},{result[7], result[6]},{result[5], result[4]},
    {result[3], result[2]}, {result[1], result[0]}}; //breaks parameterization
  //localparam [1:NUM_BITS / 4][1:0] lod_l2 = {{, result[6]},{result[5], result[4]}, {result[3], result[2]}, {result[1], result[0]}};
  assign bit16_c2 = {0, bit8_c3};
  
  LOD_2bit lod2_l(.res(lod_l1[1]), .count(bit2_c1), .status(bit2_s1));
  LOD_2bit lod2_2 (.res(lod_l1[2]), .count(bit2_c2), .status(bit2_s2));
  LOD_2bit lod2_3 (.res(lod_l1[3]), .count(bit2_c3), .status(bit2_s3));
  LOD_2bit lod2_4 (.res(lod_l1[4]), .count(bit2_c4), .status(bit2_s4));
  LOD_2bit lod2_5 (.res(lod_l1[5]), .count(bit2_c5), .status(bit2_s5));
  LOD_2bit lod2_6 (.res(lod_l1[6]), .count(bit2_c6), .status(bit2_s6));
  LOD_2bit lod2_7 (.res(lod_l1[7]), .count(bit2_c7), .status(bit2_s7));
  LOD_2bit lod2_8 (.res(lod_l1[8]), .count(bit2_c8), .status(bit2_s8));
  LOD_2bit lod2_9 (.res(lod_l1[9]), .count(bit2_c9), .status(bit2_s9));
  LOD_2bit lod2_10 (.res(lod_l1[10]), .count(bit2_c10), .status(bit2_s10));
  LOD_2bit lod2_11 (.res(lod_l1[11]), .count(bit2_c11), .status(bit2_s11));
  LOD_2bit lod2_12 (.res(lod_l1[12]), .count(bit2_c12), .status(bit2_s12));
  
  LOD_nbit #(4,2) lod4_1 (.status1(bit2_s1), .status2(bit2_s2), .count1(bit2_c1), .count2(bit2_c2), .zcount(bit4_c1), .status(bit4_s1));
  LOD_nbit #(4,2) lod4_2 (.status1(bit2_s3), .status2(bit2_s4), .count1(bit2_c3), .count2(bit2_c4), .zcount(bit4_c2), .status(bit4_s2));
  LOD_nbit #(4,2) lod4_3 (.status1(bit2_s5), .status2(bit2_s6), .count1(bit2_c5), .count2(bit2_c6), .zcount(bit4_c3), .status(bit4_s3));
  LOD_nbit #(4,2) lod4_4 (.status1(bit2_s7), .status2(bit2_s8), .count1(bit2_c7), .count2(bit2_c8), .zcount(bit4_c4), .status(bit4_s4));
  LOD_nbit #(4,2) lod4_5 (.status1(bit2_s9), .status2(bit2_s10), .count1(bit2_c9), .count2(bit2_c10), .zcount(bit4_c5), .status(bit4_s5));
  LOD_nbit #(4,2) lod4_6 (.status1(bit2_s11), .status2(bit2_s12), .count1(bit2_c11), .count2(bit2_c12), .zcount(bit4_c6), .status(bit4_s6));
  
  
  LOD_nbit #(8,3) lod8_l (.status1(bit4_s1), .status2(bit4_s2), .count1(bit4_c1), .count2(bit4_c2), .zcount(bit8_c1), .status(bit8_s1));  
  LOD_nbit #(8,3) lod8_2 (.status1(bit4_s3), .status2(bit4_s4), .count1(bit4_c3), .count2(bit4_c4), .zcount(bit8_c2), .status(bit8_s2)); 
  LOD_nbit #(8,3) lod8_3 (.status1(bit4_s5), .status2(bit4_s6), .count1(bit4_c5), .count2(bit4_c6), .zcount(bit8_c3), .status(bit8_s3)); 
  
  
  LOD_nbit #(16,4) lod16_1 (.status1(bit8_s1), .status2(bit8_s2), .count1(bit8_c1), .count2(bit8_c2), .zcount(bit16_c1), .status(bit16_s1));
  //LOD_nbit #(16,4) lod16_2 (.status1(bit8_s3), .status2(1'b0), .count1(bit8c_3), .count2(3'b111), .zcount(bit16_c2), .status(bit16_s2));
  
  LOD_nbit #(32,5) lod32_l (.status1(bit16_s1), .status2(bit8_s3), .count1(bit16_c1), .count2(bit16_c2), .zcount(shift), .status(status));
  
  assign lzc = (shift ^ 5'b10111)? shift : 0;
  
endmodule