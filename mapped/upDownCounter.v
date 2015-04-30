
module upDownCounter ( clk, n_rst, up, down, count_out );
  output [3:0] count_out;
  input clk, n_rst, up, down;
  wire   N13, N14, N15, N16, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42;

  DFFSR \count_out_reg[0]  ( .D(N13), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(N14), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(N15), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(N16), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  XOR2X1 U29 ( .A(count_out[3]), .B(n26), .Y(N16) );
  NOR2X1 U30 ( .A(n27), .B(n28), .Y(n26) );
  XOR2X1 U31 ( .A(n29), .B(up), .Y(n28) );
  OAI21X1 U32 ( .A(n30), .B(n31), .C(n32), .Y(n29) );
  OAI21X1 U33 ( .A(count_out[2]), .B(n33), .C(n34), .Y(n32) );
  XOR2X1 U34 ( .A(n31), .B(n35), .Y(N15) );
  NAND2X1 U35 ( .A(n36), .B(n37), .Y(n35) );
  XOR2X1 U36 ( .A(up), .B(n30), .Y(n36) );
  INVX1 U37 ( .A(n33), .Y(n30) );
  OAI21X1 U38 ( .A(n38), .B(n39), .C(n40), .Y(n33) );
  OAI21X1 U39 ( .A(count_out[0]), .B(count_out[1]), .C(n34), .Y(n40) );
  INVX1 U40 ( .A(count_out[2]), .Y(n31) );
  XOR2X1 U41 ( .A(n39), .B(n41), .Y(N14) );
  NAND2X1 U42 ( .A(n42), .B(n37), .Y(n41) );
  XOR2X1 U43 ( .A(n38), .B(up), .Y(n42) );
  INVX1 U44 ( .A(count_out[0]), .Y(n38) );
  INVX1 U45 ( .A(count_out[1]), .Y(n39) );
  XOR2X1 U46 ( .A(count_out[0]), .B(n37), .Y(N13) );
  INVX1 U47 ( .A(n27), .Y(n37) );
  XOR2X1 U48 ( .A(n34), .B(down), .Y(n27) );
  INVX1 U49 ( .A(up), .Y(n34) );
endmodule

