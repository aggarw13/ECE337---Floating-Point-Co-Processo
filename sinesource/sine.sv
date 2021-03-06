// $Id: $
// File name:   sine.sv
// Created:     4/29/2015
// Author:      Sung Yeon Choi
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sine block using multiply and add

module sine
  (
    input reg [31:0] operand,
    input reg sineEna,
    input reg clk,
    input reg nrst,
    input reg [3:0] in_dest,
    output reg [31:0] result,
    output reg done,
    output reg [3:0] out_dest
  );
  
  //Signals
  reg [1:16][31:0] x; //Input x
  reg dummy0, dummy1;//dummy signals. Always 0 for 0 and 1 for 1.
  reg [1:10] d; //dummy dones
  reg [3:0] dest1, dest2, dest3; //dummy input destination address
  reg [1:10][3:0] ddest; //dummy output destination address
  reg [1:12][31:0] x2; //x^2
  reg [1:2][31:0] x3; //x^3. No need for propagation but pass through stage
  reg [1:2][31:0] x5; //x^5. Same comments as x^3
  reg [1:2][31:0] x7; //x^7
  reg [1:2][31:0] x3fac; //-x^3/3!
  reg [1:2][31:0] x5fac; //x^5/5!
  reg [1:2][31:0] x7fac; //x^7/7!
  reg [1:2][31:0] firstAdd; //x-x^3/3!
  reg [1:2][31:0] secondAdd; //x-x^3/3!+x^5/5!
  reg [1:2][31:0] thirdAdd; //x-x^3/3!+x^5/5!-x^7/7!, goes straight to results  
  reg [31:0] fac3, fac5, fac7; //factorial values like -1/3!, etc. Hard coded
  reg [1:30] enable; //enable signal to sine. Ultimately used for done signal
  reg [1:30][3:0] des; //destination address propagation
  
  //Assign dummy values
  assign dummy0 = 1'b0;
  assign dummy1 = 1'b1;
  assign dest1 = 4'b0001;
  assign dest2 = 4'b0010;
  assign dest3 = 4'b0011;
  assign fac3 = 32'b10111110001010101010101010101011;
  assign fac5 = 32'b00111100000010001000100010001001;
  assign fac7 = 32'b10111001010100000000110100000001;
  
  //enable propagation
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      enable[1:30] <= 0;
      done <= 0;
    end else begin
      enable[1] <= sineEna;
      enable[2:30] <= enable[1:29];
      done <= enable[30];
    end
  end
  
  //destination propagation
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      des[1:30] <= 0;
      out_dest <= 0;
    end else begin
      des[1] <= in_dest;
      des[2:30] <= des[1:29];
      out_dest <= des[30];
    end
  end
  
  //X propagation
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x[1:16] <= 0;
    end else begin
      x[1] <= operand;
      x[2:16] <= x[1:15];
    end
  end 
  
  //X2 propagation
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x2[2:12] <= 0;
    end else begin
      x2[2] <= x2[1];
      x2[3:12] <= x2[2:11];
    end
  end 
  
  //Stage 2
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x3[2] <= 0;
    end else begin
      x3[2] <= x3[1];
    end
  end 
  
  //Stage 3
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x5[2] <= 0;
    end else begin
      x5[2] <= x5[1];
    end
  end 
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x3fac[2] <= 0;
    end else begin
      x3fac[2] <= x3fac[1];
    end
  end
  
  //Stage 4
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x7[2] <= 0;
    end else begin
      x7[2] <= x7[1];
    end
  end 
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x5fac[2] <= 0;
    end else begin
      x5fac[2] <= x5fac[1];
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      firstAdd[2] <= 0;
    end else begin
      firstAdd[2] <= firstAdd[1];
    end
  end
  
  //Stage 5
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      x7fac[2] <= 0;
    end else begin
      x7fac[2] <= x7fac[1];
    end
  end
  
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      secondAdd[2] <= 0;
    end else begin
      secondAdd[2] <= secondAdd[1];
    end
  end
  
  //Stage 6 (Output)
  always @(posedge clk, negedge nrst) begin
    if(nrst == 1'b0) begin
      thirdAdd[2] <= 0;
    end else begin
      thirdAdd[2] <= thirdAdd[1];
    end
  end
  
  assign result = thirdAdd[2];
  
  //Stage 1 x^2
  multiply MULX2
  (
	 .clk(clk),
	 .nrst(nrst),
	 .operand1(x[1]),
	 .operand2(x[1]),
	 .mulEna(dummy1),
	 .in_dest(dest1),
	 .result(x2[1]),
	 .done(d[1]),
	 .out_dest(ddest[1])
	);
	
	//Stage 2 x^3
  multiply MULX3
  (
	 .clk(clk),
	 .nrst(nrst),
	 .operand1(x[6]),
	 .operand2(x2[2]),
	 .mulEna(dummy1),
	 .in_dest(dest1),
	 .result(x3[1]),
	 .done(d[2]),
	 .out_dest(ddest[2])
  );
  
  //Stage 3 -x^3/3! and x^5
  multiply MULX5
  (
	 .clk(clk),
	 .nrst(nrst),
	 .operand1(x3[2]),
	 .operand2(x2[7]),
	 .mulEna(dummy1),
	 .in_dest(dest1),
	 .result(x5[1]),
	 .done(d[3]),
	 .out_dest(ddest[3])
  );
  
  multiply MULX3FAC
  (	 
   .clk(clk),
	 .nrst(nrst),
	 .operand1(x3[2]),
	 .operand2(fac3),
	 .mulEna(dummy1),
	 .in_dest(dest2),
	 .result(x3fac[1]),
	 .done(d[4]),
	 .out_dest(ddest[4])
  );
  
  //Stage 4 1 Addition(x-x^3/3!) and 2 Multiplication (x^7, x^5/5!)
  add_block ADDX3
  (
    .clk(clk),
    .nreset(nrst),
    .opA(x[16]),
    .opB(x3fac[2]),
    .dest_in(dest3),
    .new_instr(dummy1),
    .result(firstAdd[1]),
    .write_enable(d[7]),
    .reg_dest(ddest[7])
  );
  
  multiply MULX7
  (
	 .clk(clk),
	 .nrst(nrst),
	 .operand1(x5[2]),
	 .operand2(x2[12]),
	 .mulEna(dummy1),
	 .in_dest(dest1),
	 .result(x7[1]),
	 .done(d[5]),
	 .out_dest(ddest[5])
  );
  
  multiply MULX5FAC
  (	 
   .clk(clk),
	 .nrst(nrst),
	 .operand1(x5[2]),
	 .operand2(fac5),
	 .mulEna(dummy1),
	 .in_dest(dest2),
	 .result(x5fac[1]),
	 .done(d[6]),
	 .out_dest(ddest[6])
  );
  
  //Stage 5 1 Addition(x-x^3/3!+x^5/5!) and 1 Multiplication (-x^7/7!)
  add_block ADDX5
  (
    .clk(clk),
    .nreset(nrst),
    .opA(firstAdd[2]),
    .opB(x5fac[2]),
    .dest_in(dest3),
    .new_instr(dummy1),
    .result(secondAdd[1]),
    .write_enable(d[9]),
    .reg_dest(ddest[9])
  );
  
  multiply MULX7FAC
  (
   .clk(clk),
	 .nrst(nrst),
	 .operand1(x7[2]),
	 .operand2(fac7),
	 .mulEna(dummy1),
	 .in_dest(dest2),
	 .result(x7fac[1]),
	 .done(d[8]),
	 .out_dest(ddest[8])
	 );
  
  
  //Stage 6 1 Addition(x-x^3/3!+x^5/5!-x^7/7!)
  add_block ADDX7
  (
    .clk(clk),
    .nreset(nrst),
    .opA(secondAdd[2]),
    .opB(x7fac[2]),
    .dest_in(dest3),
    .new_instr(dummy1),
    .result(thirdAdd[1]),
    .write_enable(d[10]),
    .reg_dest(ddest[10])
  );
  
endmodule