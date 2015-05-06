// Verilog for ECE337 Lab 1
// The Following code is used to compare 2 16-bit quantites, a and b. The code 
// determines whether or not:
// a is greater than b, gt = 1, lt = 0, eq = 0
// a is less than b, gt = 0, lt = 1, eq = 0
// a is equal to b, gt = 0, lt = 0, eq = 1



module comparator
(
	input wire [22:0] a,
	input wire [22:0] b,
	output logic gt,
	output logic lt,
	output logic eq
);

	reg gte;
	reg lte;
  assign eq = (a == b)? 1'b1 : 1'b0;
  assign lt = !({1'b0, a} > {1'b0, b}) & !eq; 
  assign gt = !({1'b0, b} > {1'b0, a}) & !eq;


endmodule