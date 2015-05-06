// Module for Handling Error and Special Condition Requirmenets
module exception_handling(
  input wire ovf,
  input wire [7:0] sel_exp,
  input wire [4:0] lzc_shift,
  input wire eop,
  input wire [22 : 0] norm_mant,
  output reg [22 : 0] mantissa,
  output reg [7 : 0] exp
  );
  
  logic [8:0] res_exp;
  
  //Calculating Resultant Exponent for checking Underflow condition
  assign res_exp = {1'b0, sel_exp} - lzc_shift;
  
  always_comb begin
    mantissa = norm_mant;
    exp = sel_exp;
    //Checking NaN
    if(sel_exp == 8'hff && {1'b0, mantissa} > 0) begin 
      mantissa = 1;
    end
    //Handling Overflow Condition to Round to Infinity
    if(ovf) begin
      mantissa = (sel_exp == 254)? '0 : norm_mant;
      exp = (sel_exp ^ 8'hff)? sel_exp + ovf : 8'hff;
    end  
    //Checking Undeflow Condition
    else if({1'b0, sel_exp} < lzc_shift) 
      mantissa = 0;
    //Normal Result Cases
    else begin 
      exp = eop? sel_exp : {1'b0, sel_exp} - lzc_shift;
    end
  end
endmodule