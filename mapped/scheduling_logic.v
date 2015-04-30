
module scheduling_logic ( instruction1, dependency, instruction_available, 
        dependency_add, sram_address_store, sram_address_load, source1, 
        source2, read_instruction1, store2_enable, store1_enable, load_enable, 
        add_enable, sub_enable, mul_enable, sin_enable, neg_enable, abs_enable, 
        move_enable, add_dest, sub_dest, mul_dest, sin_dest, neg_dest, 
        abs_dest, move_dest );
  input [15:0] instruction1;
  input [15:0] dependency;
  output [15:0] dependency_add;
  output [7:0] sram_address_store;
  output [7:0] sram_address_load;
  output [3:0] source1;
  output [3:0] source2;
  output [3:0] add_dest;
  output [3:0] sub_dest;
  output [3:0] mul_dest;
  output [3:0] sin_dest;
  output [3:0] neg_dest;
  output [3:0] abs_dest;
  output [3:0] move_dest;
  input instruction_available;
  output read_instruction1, store2_enable, store1_enable, load_enable,
         add_enable, sub_enable, mul_enable, sin_enable, neg_enable,
         abs_enable, move_enable;
  wire   N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N293,
         N560, N561, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n237, n238, n239,
         n240, n241;
  assign N50 = instruction1[0];
  assign N51 = instruction1[1];
  assign N52 = instruction1[2];
  assign N53 = instruction1[3];
  assign N54 = instruction1[8];
  assign N55 = instruction1[9];
  assign N56 = instruction1[10];
  assign N57 = instruction1[11];
  assign N58 = instruction1[4];
  assign N59 = instruction1[5];
  assign N60 = instruction1[6];
  assign N61 = instruction1[7];

  NOR2X1 U193 ( .A(n121), .B(n122), .Y(sub_dest[3]) );
  NOR2X1 U194 ( .A(n121), .B(n123), .Y(sub_dest[2]) );
  NOR2X1 U195 ( .A(n121), .B(n124), .Y(sub_dest[1]) );
  NOR2X1 U196 ( .A(n121), .B(n125), .Y(sub_dest[0]) );
  OAI22X1 U197 ( .A(n126), .B(n127), .C(n122), .D(n128), .Y(
        sram_address_store[7]) );
  OAI22X1 U198 ( .A(n126), .B(n129), .C(n123), .D(n128), .Y(
        sram_address_store[6]) );
  OAI22X1 U199 ( .A(n126), .B(n130), .C(n124), .D(n128), .Y(
        sram_address_store[5]) );
  OAI22X1 U200 ( .A(n126), .B(n131), .C(n125), .D(n128), .Y(
        sram_address_store[4]) );
  OAI22X1 U201 ( .A(n126), .B(n132), .C(n128), .D(n127), .Y(
        sram_address_store[3]) );
  OAI22X1 U202 ( .A(n126), .B(n133), .C(n128), .D(n129), .Y(
        sram_address_store[2]) );
  OAI22X1 U203 ( .A(n126), .B(n134), .C(n128), .D(n130), .Y(
        sram_address_store[1]) );
  OAI22X1 U204 ( .A(n126), .B(n135), .C(n128), .D(n131), .Y(
        sram_address_store[0]) );
  NOR2X1 U205 ( .A(n127), .B(n136), .Y(sram_address_load[7]) );
  NOR2X1 U206 ( .A(n129), .B(n136), .Y(sram_address_load[6]) );
  NOR2X1 U207 ( .A(n130), .B(n136), .Y(sram_address_load[5]) );
  NOR2X1 U208 ( .A(n131), .B(n136), .Y(sram_address_load[4]) );
  NOR2X1 U209 ( .A(n132), .B(n136), .Y(sram_address_load[3]) );
  NOR2X1 U210 ( .A(n133), .B(n136), .Y(sram_address_load[2]) );
  NOR2X1 U211 ( .A(n134), .B(n136), .Y(sram_address_load[1]) );
  NOR2X1 U212 ( .A(n135), .B(n136), .Y(sram_address_load[0]) );
  NOR2X1 U213 ( .A(n137), .B(n132), .Y(source2[3]) );
  INVX1 U214 ( .A(N53), .Y(n132) );
  NOR2X1 U215 ( .A(n137), .B(n133), .Y(source2[2]) );
  INVX1 U216 ( .A(N52), .Y(n133) );
  NOR2X1 U217 ( .A(n137), .B(n134), .Y(source2[1]) );
  INVX1 U218 ( .A(N51), .Y(n134) );
  NOR2X1 U219 ( .A(n137), .B(n135), .Y(source2[0]) );
  INVX1 U220 ( .A(N50), .Y(n135) );
  OAI22X1 U221 ( .A(n122), .B(n126), .C(n138), .D(n127), .Y(source1[3]) );
  INVX1 U222 ( .A(N61), .Y(n127) );
  OAI22X1 U223 ( .A(n123), .B(n126), .C(n138), .D(n129), .Y(source1[2]) );
  INVX1 U224 ( .A(N60), .Y(n129) );
  OAI22X1 U225 ( .A(n124), .B(n126), .C(n138), .D(n130), .Y(source1[1]) );
  INVX1 U226 ( .A(N59), .Y(n130) );
  OAI22X1 U227 ( .A(n125), .B(n126), .C(n138), .D(n131), .Y(source1[0]) );
  INVX1 U228 ( .A(N58), .Y(n131) );
  INVX1 U229 ( .A(n139), .Y(n138) );
  NAND3X1 U230 ( .A(n140), .B(n141), .C(n142), .Y(n139) );
  NOR2X1 U231 ( .A(add_enable), .B(n143), .Y(n142) );
  NAND2X1 U232 ( .A(n144), .B(n121), .Y(n143) );
  OAI21X1 U233 ( .A(n145), .B(n146), .C(instruction_available), .Y(n140) );
  INVX1 U234 ( .A(store2_enable), .Y(n126) );
  NOR2X1 U235 ( .A(n147), .B(n148), .Y(store2_enable) );
  NAND3X1 U236 ( .A(instruction_available), .B(n149), .C(instruction1[12]), 
        .Y(n148) );
  NAND3X1 U237 ( .A(n150), .B(n151), .C(n152), .Y(n147) );
  NOR2X1 U238 ( .A(n122), .B(n153), .Y(sin_dest[3]) );
  NOR2X1 U239 ( .A(n123), .B(n153), .Y(sin_dest[2]) );
  NOR2X1 U240 ( .A(n124), .B(n153), .Y(sin_dest[1]) );
  NOR2X1 U241 ( .A(n125), .B(n153), .Y(sin_dest[0]) );
  OAI21X1 U242 ( .A(n154), .B(n155), .C(n156), .Y(read_instruction1) );
  NOR2X1 U243 ( .A(move_enable), .B(abs_enable), .Y(n156) );
  OAI21X1 U244 ( .A(n157), .B(n158), .C(instruction_available), .Y(n155) );
  NOR2X1 U245 ( .A(n159), .B(n160), .Y(n158) );
  OAI21X1 U246 ( .A(n151), .B(n161), .C(n162), .Y(n154) );
  MUX2X1 U247 ( .B(n163), .A(N293), .S(n159), .Y(n162) );
  OAI21X1 U248 ( .A(n164), .B(n149), .C(n165), .Y(n163) );
  NAND3X1 U249 ( .A(N560), .B(instruction1[12]), .C(n166), .Y(n165) );
  NAND2X1 U250 ( .A(n152), .B(n150), .Y(n161) );
  INVX1 U251 ( .A(n128), .Y(store1_enable) );
  NAND3X1 U252 ( .A(n167), .B(n168), .C(instruction1[13]), .Y(n128) );
  INVX1 U253 ( .A(n169), .Y(n167) );
  INVX1 U254 ( .A(n170), .Y(abs_enable) );
  INVX1 U255 ( .A(n141), .Y(move_enable) );
  INVX1 U256 ( .A(n144), .Y(mul_enable) );
  INVX1 U257 ( .A(n121), .Y(sub_enable) );
  NAND3X1 U258 ( .A(n171), .B(n168), .C(instruction_available), .Y(n121) );
  INVX1 U259 ( .A(n172), .Y(add_enable) );
  INVX1 U260 ( .A(n153), .Y(sin_enable) );
  NAND3X1 U261 ( .A(instruction_available), .B(n168), .C(n145), .Y(n153) );
  INVX1 U262 ( .A(n173), .Y(neg_enable) );
  INVX1 U263 ( .A(n136), .Y(load_enable) );
  NOR2X1 U264 ( .A(n122), .B(n173), .Y(neg_dest[3]) );
  NOR2X1 U265 ( .A(n123), .B(n173), .Y(neg_dest[2]) );
  NOR2X1 U266 ( .A(n124), .B(n173), .Y(neg_dest[1]) );
  NOR2X1 U267 ( .A(n125), .B(n173), .Y(neg_dest[0]) );
  NAND3X1 U268 ( .A(instruction1[12]), .B(instruction_available), .C(n145), 
        .Y(n173) );
  INVX1 U269 ( .A(n174), .Y(n145) );
  NOR2X1 U270 ( .A(n122), .B(n144), .Y(mul_dest[3]) );
  NOR2X1 U271 ( .A(n123), .B(n144), .Y(mul_dest[2]) );
  NOR2X1 U272 ( .A(n124), .B(n144), .Y(mul_dest[1]) );
  NOR2X1 U273 ( .A(n125), .B(n144), .Y(mul_dest[0]) );
  NAND3X1 U274 ( .A(instruction_available), .B(n171), .C(instruction1[12]), 
        .Y(n144) );
  INVX1 U275 ( .A(n175), .Y(n171) );
  NAND3X1 U276 ( .A(n176), .B(n152), .C(n177), .Y(n175) );
  NOR2X1 U277 ( .A(n122), .B(n141), .Y(move_dest[3]) );
  NOR2X1 U278 ( .A(n123), .B(n141), .Y(move_dest[2]) );
  NOR2X1 U279 ( .A(n124), .B(n141), .Y(move_dest[1]) );
  NOR2X1 U280 ( .A(n125), .B(n141), .Y(move_dest[0]) );
  NOR2X1 U281 ( .A(n178), .B(n179), .Y(dependency_add[9]) );
  NOR2X1 U282 ( .A(n178), .B(n180), .Y(dependency_add[8]) );
  NOR2X1 U283 ( .A(n181), .B(n182), .Y(dependency_add[7]) );
  NOR2X1 U284 ( .A(n182), .B(n183), .Y(dependency_add[6]) );
  NOR2X1 U285 ( .A(n179), .B(n182), .Y(dependency_add[5]) );
  NOR2X1 U286 ( .A(n180), .B(n182), .Y(dependency_add[4]) );
  NAND2X1 U287 ( .A(n184), .B(N56), .Y(n182) );
  NOR2X1 U288 ( .A(n181), .B(n185), .Y(dependency_add[3]) );
  NOR2X1 U289 ( .A(n183), .B(n185), .Y(dependency_add[2]) );
  NOR2X1 U290 ( .A(n179), .B(n185), .Y(dependency_add[1]) );
  NOR2X1 U291 ( .A(n181), .B(n186), .Y(dependency_add[15]) );
  NOR2X1 U292 ( .A(n183), .B(n186), .Y(dependency_add[14]) );
  NOR2X1 U293 ( .A(n179), .B(n186), .Y(dependency_add[13]) );
  NAND2X1 U294 ( .A(N54), .B(n124), .Y(n179) );
  NOR2X1 U295 ( .A(n180), .B(n186), .Y(dependency_add[12]) );
  NAND3X1 U296 ( .A(N57), .B(n187), .C(N56), .Y(n186) );
  NOR2X1 U297 ( .A(n178), .B(n181), .Y(dependency_add[11]) );
  NAND2X1 U298 ( .A(N54), .B(N55), .Y(n181) );
  NOR2X1 U299 ( .A(n178), .B(n183), .Y(dependency_add[10]) );
  NAND2X1 U300 ( .A(N55), .B(n125), .Y(n183) );
  NAND3X1 U301 ( .A(n187), .B(n123), .C(N57), .Y(n178) );
  NOR2X1 U302 ( .A(n180), .B(n185), .Y(dependency_add[0]) );
  NAND2X1 U303 ( .A(n184), .B(n123), .Y(n185) );
  AND2X1 U304 ( .A(n187), .B(n122), .Y(n184) );
  OR2X1 U305 ( .A(n188), .B(n189), .Y(n187) );
  OAI21X1 U306 ( .A(n190), .B(n174), .C(n170), .Y(n189) );
  NAND2X1 U307 ( .A(n160), .B(n157), .Y(n174) );
  NOR2X1 U308 ( .A(n152), .B(n191), .Y(n160) );
  INVX1 U309 ( .A(instruction_available), .Y(n190) );
  NAND3X1 U310 ( .A(n137), .B(n136), .C(n141), .Y(n188) );
  NAND3X1 U311 ( .A(n157), .B(n152), .C(n192), .Y(n141) );
  NOR2X1 U312 ( .A(n168), .B(n169), .Y(n192) );
  NAND3X1 U313 ( .A(instruction_available), .B(n150), .C(instruction1[15]), 
        .Y(n169) );
  INVX1 U314 ( .A(instruction1[13]), .Y(n152) );
  NAND3X1 U315 ( .A(instruction_available), .B(n149), .C(n193), .Y(n136) );
  INVX1 U316 ( .A(n164), .Y(n193) );
  NAND3X1 U317 ( .A(instruction1[13]), .B(n168), .C(n194), .Y(n164) );
  INVX1 U318 ( .A(N560), .Y(n149) );
  NAND3X1 U319 ( .A(n176), .B(n159), .C(instruction_available), .Y(n137) );
  OAI21X1 U320 ( .A(instruction1[13]), .B(n191), .C(n195), .Y(n159) );
  INVX1 U321 ( .A(n177), .Y(n191) );
  NOR2X1 U322 ( .A(n150), .B(instruction1[15]), .Y(n177) );
  INVX1 U323 ( .A(instruction1[14]), .Y(n150) );
  NAND2X1 U324 ( .A(n125), .B(n124), .Y(n180) );
  NOR2X1 U325 ( .A(n122), .B(n172), .Y(add_dest[3]) );
  NOR2X1 U326 ( .A(n123), .B(n172), .Y(add_dest[2]) );
  NOR2X1 U327 ( .A(n124), .B(n172), .Y(add_dest[1]) );
  NOR2X1 U328 ( .A(n125), .B(n172), .Y(add_dest[0]) );
  NAND3X1 U329 ( .A(instruction_available), .B(n176), .C(n196), .Y(n172) );
  INVX1 U330 ( .A(n195), .Y(n196) );
  NAND3X1 U331 ( .A(instruction1[13]), .B(instruction1[12]), .C(n194), .Y(n195) );
  NOR2X1 U332 ( .A(instruction1[15]), .B(instruction1[14]), .Y(n194) );
  NOR2X1 U333 ( .A(n197), .B(N293), .Y(n176) );
  NOR2X1 U334 ( .A(n122), .B(n170), .Y(abs_dest[3]) );
  INVX1 U335 ( .A(N57), .Y(n122) );
  NOR2X1 U336 ( .A(n123), .B(n170), .Y(abs_dest[2]) );
  INVX1 U337 ( .A(N56), .Y(n123) );
  NOR2X1 U338 ( .A(n124), .B(n170), .Y(abs_dest[1]) );
  INVX1 U339 ( .A(N55), .Y(n124) );
  NOR2X1 U340 ( .A(n125), .B(n170), .Y(abs_dest[0]) );
  NAND2X1 U341 ( .A(n146), .B(instruction_available), .Y(n170) );
  INVX1 U342 ( .A(n198), .Y(n146) );
  NAND3X1 U343 ( .A(n166), .B(n168), .C(n199), .Y(n198) );
  NOR2X1 U344 ( .A(n197), .B(n151), .Y(n199) );
  INVX1 U345 ( .A(instruction1[15]), .Y(n151) );
  INVX1 U346 ( .A(n157), .Y(n197) );
  NOR2X1 U347 ( .A(N561), .B(N560), .Y(n157) );
  INVX1 U348 ( .A(instruction1[12]), .Y(n168) );
  NOR2X1 U349 ( .A(instruction1[14]), .B(instruction1[13]), .Y(n166) );
  INVX1 U350 ( .A(N54), .Y(n125) );
  MUX2X1 U351 ( .B(n201), .A(n202), .S(N51), .Y(n200) );
  MUX2X1 U352 ( .B(n204), .A(n205), .S(N51), .Y(n203) );
  MUX2X1 U353 ( .B(n207), .A(n208), .S(N51), .Y(n206) );
  MUX2X1 U354 ( .B(n210), .A(n211), .S(N51), .Y(n209) );
  MUX2X1 U355 ( .B(n212), .A(n213), .S(N53), .Y(N293) );
  MUX2X1 U356 ( .B(dependency[14]), .A(dependency[15]), .S(N50), .Y(n202) );
  MUX2X1 U357 ( .B(dependency[12]), .A(dependency[13]), .S(N50), .Y(n201) );
  MUX2X1 U358 ( .B(dependency[10]), .A(dependency[11]), .S(N50), .Y(n205) );
  MUX2X1 U359 ( .B(dependency[8]), .A(dependency[9]), .S(N50), .Y(n204) );
  MUX2X1 U360 ( .B(n203), .A(n200), .S(N52), .Y(n213) );
  MUX2X1 U361 ( .B(dependency[6]), .A(dependency[7]), .S(N50), .Y(n208) );
  MUX2X1 U362 ( .B(dependency[4]), .A(dependency[5]), .S(N50), .Y(n207) );
  MUX2X1 U363 ( .B(dependency[2]), .A(dependency[3]), .S(N50), .Y(n211) );
  MUX2X1 U364 ( .B(dependency[0]), .A(dependency[1]), .S(N50), .Y(n210) );
  MUX2X1 U365 ( .B(n209), .A(n206), .S(N52), .Y(n212) );
  MUX2X1 U366 ( .B(n215), .A(n216), .S(N55), .Y(n214) );
  MUX2X1 U367 ( .B(n218), .A(n219), .S(N55), .Y(n217) );
  MUX2X1 U368 ( .B(n221), .A(n222), .S(N55), .Y(n220) );
  MUX2X1 U369 ( .B(n224), .A(n225), .S(N55), .Y(n223) );
  MUX2X1 U370 ( .B(n226), .A(n227), .S(N57), .Y(N560) );
  MUX2X1 U371 ( .B(dependency[14]), .A(dependency[15]), .S(N54), .Y(n216) );
  MUX2X1 U372 ( .B(dependency[12]), .A(dependency[13]), .S(N54), .Y(n215) );
  MUX2X1 U373 ( .B(dependency[10]), .A(dependency[11]), .S(N54), .Y(n219) );
  MUX2X1 U374 ( .B(dependency[8]), .A(dependency[9]), .S(N54), .Y(n218) );
  MUX2X1 U375 ( .B(n217), .A(n214), .S(N56), .Y(n227) );
  MUX2X1 U376 ( .B(dependency[6]), .A(dependency[7]), .S(N54), .Y(n222) );
  MUX2X1 U377 ( .B(dependency[4]), .A(dependency[5]), .S(N54), .Y(n221) );
  MUX2X1 U378 ( .B(dependency[2]), .A(dependency[3]), .S(N54), .Y(n225) );
  MUX2X1 U379 ( .B(dependency[0]), .A(dependency[1]), .S(N54), .Y(n224) );
  MUX2X1 U380 ( .B(n223), .A(n220), .S(N56), .Y(n226) );
  MUX2X1 U381 ( .B(n229), .A(n230), .S(N59), .Y(n228) );
  MUX2X1 U382 ( .B(n232), .A(n233), .S(N59), .Y(n231) );
  MUX2X1 U383 ( .B(n235), .A(n236), .S(N59), .Y(n234) );
  MUX2X1 U384 ( .B(n238), .A(n239), .S(N59), .Y(n237) );
  MUX2X1 U385 ( .B(n240), .A(n241), .S(N61), .Y(N561) );
  MUX2X1 U386 ( .B(dependency[14]), .A(dependency[15]), .S(N58), .Y(n230) );
  MUX2X1 U387 ( .B(dependency[12]), .A(dependency[13]), .S(N58), .Y(n229) );
  MUX2X1 U388 ( .B(dependency[10]), .A(dependency[11]), .S(N58), .Y(n233) );
  MUX2X1 U389 ( .B(dependency[8]), .A(dependency[9]), .S(N58), .Y(n232) );
  MUX2X1 U390 ( .B(n231), .A(n228), .S(N60), .Y(n241) );
  MUX2X1 U391 ( .B(dependency[6]), .A(dependency[7]), .S(N58), .Y(n236) );
  MUX2X1 U392 ( .B(dependency[4]), .A(dependency[5]), .S(N58), .Y(n235) );
  MUX2X1 U393 ( .B(dependency[2]), .A(dependency[3]), .S(N58), .Y(n239) );
  MUX2X1 U394 ( .B(dependency[0]), .A(dependency[1]), .S(N58), .Y(n238) );
  MUX2X1 U395 ( .B(n237), .A(n234), .S(N60), .Y(n240) );
endmodule

