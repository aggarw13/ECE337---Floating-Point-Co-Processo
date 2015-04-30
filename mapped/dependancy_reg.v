
module dependancy_reg ( clk, n_rst, dependency_set, dependency_remove, 
        dependency_exists );
  input [15:0] dependency_set;
  input [15:0] dependency_remove;
  output [15:0] dependency_exists;
  input clk, n_rst;
  wire   n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64;
  wire   [15:0] dependency;

  DFFSR \dependency_reg[15]  ( .D(n48), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[15]) );
  DFFSR \dependency_reg[14]  ( .D(n47), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[14]) );
  DFFSR \dependency_reg[13]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[13]) );
  DFFSR \dependency_reg[12]  ( .D(n45), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[12]) );
  DFFSR \dependency_reg[11]  ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[11]) );
  DFFSR \dependency_reg[10]  ( .D(n43), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[10]) );
  DFFSR \dependency_reg[9]  ( .D(n42), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[9]) );
  DFFSR \dependency_reg[8]  ( .D(n41), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[8]) );
  DFFSR \dependency_reg[7]  ( .D(n40), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[7]) );
  DFFSR \dependency_reg[6]  ( .D(n39), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[6]) );
  DFFSR \dependency_reg[5]  ( .D(n38), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[5]) );
  DFFSR \dependency_reg[4]  ( .D(n37), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[4]) );
  DFFSR \dependency_reg[3]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[3]) );
  DFFSR \dependency_reg[2]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[2]) );
  DFFSR \dependency_reg[1]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[1]) );
  DFFSR \dependency_reg[0]  ( .D(n33), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        dependency[0]) );
  OR2X1 U67 ( .A(dependency_exists[15]), .B(dependency_set[15]), .Y(n48) );
  OR2X1 U68 ( .A(dependency_exists[14]), .B(dependency_set[14]), .Y(n47) );
  OR2X1 U69 ( .A(dependency_exists[13]), .B(dependency_set[13]), .Y(n46) );
  OR2X1 U70 ( .A(dependency_exists[12]), .B(dependency_set[12]), .Y(n45) );
  OR2X1 U71 ( .A(dependency_exists[11]), .B(dependency_set[11]), .Y(n44) );
  OR2X1 U72 ( .A(dependency_exists[10]), .B(dependency_set[10]), .Y(n43) );
  OR2X1 U73 ( .A(dependency_exists[9]), .B(dependency_set[9]), .Y(n42) );
  OR2X1 U74 ( .A(dependency_exists[8]), .B(dependency_set[8]), .Y(n41) );
  OR2X1 U75 ( .A(dependency_exists[7]), .B(dependency_set[7]), .Y(n40) );
  OR2X1 U76 ( .A(dependency_exists[6]), .B(dependency_set[6]), .Y(n39) );
  OR2X1 U77 ( .A(dependency_exists[5]), .B(dependency_set[5]), .Y(n38) );
  OR2X1 U78 ( .A(dependency_exists[4]), .B(dependency_set[4]), .Y(n37) );
  OR2X1 U79 ( .A(dependency_exists[3]), .B(dependency_set[3]), .Y(n36) );
  OR2X1 U80 ( .A(dependency_exists[2]), .B(dependency_set[2]), .Y(n35) );
  OR2X1 U81 ( .A(dependency_exists[1]), .B(dependency_set[1]), .Y(n34) );
  OR2X1 U82 ( .A(dependency_exists[0]), .B(dependency_set[0]), .Y(n33) );
  NOR2X1 U83 ( .A(n49), .B(dependency_remove[9]), .Y(dependency_exists[9]) );
  INVX1 U84 ( .A(dependency[9]), .Y(n49) );
  NOR2X1 U85 ( .A(n50), .B(dependency_remove[8]), .Y(dependency_exists[8]) );
  INVX1 U86 ( .A(dependency[8]), .Y(n50) );
  NOR2X1 U87 ( .A(n51), .B(dependency_remove[7]), .Y(dependency_exists[7]) );
  INVX1 U88 ( .A(dependency[7]), .Y(n51) );
  NOR2X1 U89 ( .A(n52), .B(dependency_remove[6]), .Y(dependency_exists[6]) );
  INVX1 U90 ( .A(dependency[6]), .Y(n52) );
  NOR2X1 U91 ( .A(n53), .B(dependency_remove[5]), .Y(dependency_exists[5]) );
  INVX1 U92 ( .A(dependency[5]), .Y(n53) );
  NOR2X1 U93 ( .A(n54), .B(dependency_remove[4]), .Y(dependency_exists[4]) );
  INVX1 U94 ( .A(dependency[4]), .Y(n54) );
  NOR2X1 U95 ( .A(n55), .B(dependency_remove[3]), .Y(dependency_exists[3]) );
  INVX1 U96 ( .A(dependency[3]), .Y(n55) );
  NOR2X1 U97 ( .A(n56), .B(dependency_remove[2]), .Y(dependency_exists[2]) );
  INVX1 U98 ( .A(dependency[2]), .Y(n56) );
  NOR2X1 U99 ( .A(n57), .B(dependency_remove[1]), .Y(dependency_exists[1]) );
  INVX1 U100 ( .A(dependency[1]), .Y(n57) );
  NOR2X1 U101 ( .A(n58), .B(dependency_remove[15]), .Y(dependency_exists[15])
         );
  INVX1 U102 ( .A(dependency[15]), .Y(n58) );
  NOR2X1 U103 ( .A(n59), .B(dependency_remove[14]), .Y(dependency_exists[14])
         );
  INVX1 U104 ( .A(dependency[14]), .Y(n59) );
  NOR2X1 U105 ( .A(n60), .B(dependency_remove[13]), .Y(dependency_exists[13])
         );
  INVX1 U106 ( .A(dependency[13]), .Y(n60) );
  NOR2X1 U107 ( .A(n61), .B(dependency_remove[12]), .Y(dependency_exists[12])
         );
  INVX1 U108 ( .A(dependency[12]), .Y(n61) );
  NOR2X1 U109 ( .A(n62), .B(dependency_remove[11]), .Y(dependency_exists[11])
         );
  INVX1 U110 ( .A(dependency[11]), .Y(n62) );
  NOR2X1 U111 ( .A(n63), .B(dependency_remove[10]), .Y(dependency_exists[10])
         );
  INVX1 U112 ( .A(dependency[10]), .Y(n63) );
  NOR2X1 U113 ( .A(n64), .B(dependency_remove[0]), .Y(dependency_exists[0]) );
  INVX1 U114 ( .A(dependency[0]), .Y(n64) );
endmodule

