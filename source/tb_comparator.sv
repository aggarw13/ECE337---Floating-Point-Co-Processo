
module tb_comparator();

reg [22:0] a,b;
reg [2:0] compare;

comparator COMPARE (
  .a(a),
  .b(b),
  .gt(compare[2]),
  .lt(compare[1]),
  .eq(compare[0])
  );


initial begin
  #(5);
  a = 23'b00000000001000100000000;
  b = 23'b00000000010001000000010;
  //a = 23'b000000000000000000000001;
  //b = 23'b000000000010001000000010;
end
endmodule