// Module for Error and Special Condition Requirmenets
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
  assign res_exp = {1'b0, sel_exp} - lzc_shift;
  
  always_comb begin
    mantissa = norm_mant;
    exp = sel_exp;
    if(sel_exp == 255 && mantissa > 0) begin 
      mantissa = 1;
    end
    if(ovf) begin
      mantissa = (sel_exp == 254)? '0 : norm_mant;
      exp = (sel_exp ^ 8'hff)? sel_exp + ovf : 8'hff;
    end  
    else if(res_exp <= 0) 
      mantissa = 0;
    else begin 
      exp = eop? sel_exp : {1'b0, sel_exp} - lzc_shift;
    end
  end
endmodule