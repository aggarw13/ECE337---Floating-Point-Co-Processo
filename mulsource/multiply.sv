// $Id: $
// File name:   multiply.sv
// Created:     4/21/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: floatingpoint multiplication

module multiply
  (
    input reg [31:0] operand1,
    input reg [31:0] operand2,
    input reg mulEna,
    input reg clk,
    input reg nrst,
    input reg [3:0] in_dest,
    output reg [31:0] result,
    //output reg [22:0] mant,
    //output reg [7:0] exp,
    output reg done,
    output reg [3:0] out_dest
  );
  
  reg [22:0] op1mant;
  reg [22:0] op2mant;
  reg [7:0] op1exp;
  reg [7:0] op2exp;
  reg op1sign;
  reg op2sign;
  reg sign1;
  reg sign2;
  reg signout;
  reg [8:0] exp1;
  reg [8:0] exp2;
  reg [8:0] exp3;
  reg [7:0] expout;
  reg [47:0] mult1;
  reg [47:0] mult2;
  reg eUp1;
  reg eUp2;
  reg [22:0] Sticky;
  reg S1;
  reg S2;
  reg L1;
  reg L2;
  reg G1;
  reg G2;
  reg [22:0] mant1;
  reg [22:0] mant2;
  reg [22:0] mantout;
  reg [31:0] op1;
  reg [31:0] op2;
  reg [31:0] out;
  reg [31:0] out2;
  reg stage1;
  reg stage2;
  reg stage3;
  reg [3:0] stage1dest;
  reg [3:0] stage2dest;
  reg [3:0] stage3dest;
  reg NaN;
  reg Na1;
  reg Na2;
  reg expcheck;
  
  assign op1mant = op1[22:0];
  assign op2mant = op2[22:0];
  assign op1exp = op1[30:23];
  assign op2exp = op2[30:23];
  assign op1sign = op1[31];
  assign op2sign = op2[31];
  
  always @(op1, op2) begin
    NaN = 1'b0;
    if(op1exp == 8'b11111111 && op1mant != 32'b0)
      NaN = 1'b1;
    else if(op2exp == 8'b11111111 && op2mant != 32'b0)
      NaN = 1'b1;
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      stage1dest <= 0;
      stage2dest <= 0;
      stage3dest <= 0;
      out_dest <= 0;
    end
    else begin
      out_dest <= stage3dest;
      stage3dest <= stage2dest;
      stage2dest <= stage1dest;
      if(mulEna == 1'b1)
        stage1dest <= in_dest;
      else
        stage1dest <= stage1dest;
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      Na1 <= 0;
      Na2 <= 0;
    end
    else begin
      Na2 <= Na1;
      Na1 <= NaN;
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      done <= 0;
      stage1 <= 0;
      stage2 <= 0;
      stage3 <= 0;
    end
    else begin
      done <= stage3;
      stage3 <= stage2;
      stage2 <= stage1;
      if(mulEna == 1'b1)
        stage1 <= 1'b1;
      else
        stage1 <= 1'b0;
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      sign2 <= 0;
      signout <= 0;
    end
    else begin
      signout <= sign2;
      sign2 <= sign1;
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      op1 <= 0;
      op2 <= 0;
    end
    else begin
      if(mulEna == 1'b1) begin
        op1 <= operand1;
        op2 <= operand2;
      end else begin
        op1 <= op1;
        op2 <= op2;
      end
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      exp2 <= 0;
      exp3 <= 0;
    end
    else begin
      exp2 <= exp1;
      exp3 <= exp2;
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      G2 <= 0;
      L2 <= 0;
      S2 <= 0;
    end
    else begin
      S2 <= S1;
      G2 <= G1;
      L2 <= L1;
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0)
      out2 <= 0;
    else
      out2 <= out;
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      mult2 <= 0;
      eUp2 <= 0;
      mant2 <= 0;
    end
    else begin
      mult2 <= mult1;
      eUp2 <= eUp1;
      mant2 <= mant1;
    end
  end
  
  signMul SIGN(
    .sign1(op1sign),
    .sign2(op2sign),
    .signr(sign1)
  );
  
  mul24 MUL(
    .a(op1mant),
    .b(op2mant),
    .result(mult1)
  );
  
  exponentAdd EADD(
    .exp1(op1exp),
    .exp2(op2exp),
    .result(exp1)
  );
  
  normalizeMul NORM(
    .result(mult2),
    .eUp(eUp1),
    .G(G1),
    .L(L1),
    .Sticky(Sticky),
    .mantissa(mant1)
  );
  
  sticky STICK(
    .rest(Sticky),
    .S(S1)
  );
  
  roundMul RND(
    .S(S2),
    .L(L2),
    .G(G2),
    .mant(mant2),
    .rounded(mantout)
  );
  
  exponentUp UP(
    .exp1(exp3),
    .Up(eUp2),
    .result(expout)
  );
  
  always @(expout) begin
    if(expout == 8'b11111111 && Na2 != 1'b1) //overflow
      expcheck = 1'b1;
    else if(expout == 8'b00000000 && Na2 != 1'b1) //underflow
      expcheck = 1'b1;
    else
      expcheck = 1'b0;
  end
      
  always @(expout,mantout) begin
    out = {signout,expout,mantout};
    if(Na2 == 1'b1)
      out = {signout,8'b11111111,23'b1};
    else if(expcheck == 1'b1)
      out = {signout,expout,23'b0};
  end
  
  assign result = out2;
  //assign mant = out2[22:0];
  //assign exp = out2[30:23];
  
endmodule