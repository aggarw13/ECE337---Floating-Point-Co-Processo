module subtract_block(
  input wire clk,
  input wire nreset,
  input wire [31:0] opA,
  input wire [31:0] opB,
  input wire [3:0] dest_in,
  input wire new_instr,
  output logic [31:0] result,
  output logic write_enable,
  output wire [3:0] reg_dest
  );
  
  reg [68 : 0] reg_inputs;
  reg [77 : 0] reg_stage1;
  reg [59 : 0] reg_stage2;
  reg [35 : 0] reg_stage3;
  reg [1 : 3] [0:0] reg_status;
  integer i;  
  logic [7:0] expA, expB, sel_exp_s1, exp_out;
  logic [8:0] expdiff_s1, actual_expdiff;
  logic [22:0] mantissaA, mantissaB, mant_lrgexp,  mant_smexp, prefinal_mantissa, final_mantissa;
  logic [23:0] shifted_mant, mantA_s1, mantB_s1, adder_res, norm_res;
  logic signA, signB, sign_out;
  logic eop, ovf, opA_inv, opB_inv, stage3_shift_dir;
  logic [4:0] lzc_shift;
  logic [2:0] mantissa_compare, guard_bits_s1, guard_bits_s3;
  
  always_ff @(posedge clk, negedge nreset)
  begin
    if(nreset == '0) 
      reg_status <= '0;
    else begin
      //Stage Status Registers
      /*reg_status[3]= reg_status[2];
      reg_status[2] = reg_status[1];
      reg_status[1] = reg_inputs[68];*/
      reg_status[1:3] <= {reg_inputs[68], reg_status[1:2]};
    end
  end
        
  always_ff @(posedge clk, negedge nreset) begin
    if(nreset == 1'b0) 
       reg_inputs <= '0;
    else begin
      //Input Stage registers
      reg_inputs[31:0] <= opA;
      reg_inputs[63:32] <= opB;
      reg_inputs[67:64] <= dest_in;
      reg_inputs[68] <= new_instr;
    end
  end
    
  always_ff @(posedge clk, negedge nreset) begin
    if(nreset == 1'b0) 
      reg_stage3 <= '0;
    else begin
       //Stage3 registers
      reg_stage3[31:0] <= {sign_out,exp_out,final_mantissa};
      reg_stage3[35:32] <= reg_stage2[3:0];
    end
  end
  
  always_ff @(posedge clk, negedge nreset) begin
    if(nreset == 1'b0) 
      reg_stage2 <= '0;
    else begin
      //Stage2 registers
      reg_stage2[59:58] <= reg_stage1[77:76];
      reg_stage2[57:56] <= {reg_stage1[75] , ovf};
      reg_stage2[55:53] <= reg_stage1[74:72];
      reg_stage2[52:50] <= reg_stage1[71:69];
      reg_stage2[49:41] <= reg_stage1[68:60];
      reg_stage2[40:33] <= reg_stage1[59:52];
      reg_stage2[32:9] <= adder_res;
      reg_stage2[8:4] <= lzc_shift;
      reg_stage2[3:0] <= reg_stage1; 
    end
  end
  
  always_ff @(posedge clk, negedge nreset) begin
    if(nreset == 1'b0) 
      reg_stage1 <= '0;
    else begin        
      //Stage 1 registers
      reg_stage1[77:76] <= {signA, signB};
      reg_stage1[75] <= eop;
      reg_stage1[74:72] <= mantissa_compare;
      reg_stage1[71:69] <= guard_bits_s1;
      reg_stage1[68:60] <= actual_expdiff;
      reg_stage1[59:52] <= sel_exp_s1;
      reg_stage1[51:28] <= mantA_s1;
      reg_stage1[27:4] <= mantB_s1;
      reg_stage1[3:0] <= reg_inputs[67:64]; 
    end
  end
  
  
  //Parsing Input data operands and Assigning output signals
  assign expA = reg_inputs[30:23];
  assign expB = reg_inputs[62:55];
  assign mantissaA = reg_inputs[22:0];//(reg_inputs[62:55] ~^ 8'hff && reg_inputs[54:32] ^ 23'b0)? 1 : reg_inputs[22:0]; 
  assign mantissaB = reg_inputs[54:32];//(reg_inputs[30:23] ~^ 8'hff && reg_inputs[22:0] ^ 23'b0)? 1 : reg_inputs[54:32];
  assign signA = reg_inputs[31];
  assign signB = !reg_inputs[63];
  assign eop = !(signA ^ signB);
  assign actual_expdiff = (expdiff_s1[8])? {1'b1, 0 - expdiff_s1[7:0]} : expdiff_s1; 
  //assign result = {sign_out,exp_out,final_mantissa};
  assign result = reg_stage3[31:0];
  assign stage3_shift_dir = reg_stage2[56];
  assign write_enable = reg_status[3];
  assign reg_dest = reg_stage3[35:32];

  
  //Stage 1 Instantiations
  exp_diff EXP_DIFF
  (
  .Ea({1'b0, expA}),
  .Eb({1'b0, expB}),
  .Ediff(expdiff_s1)
  );
  
  exp_mux LARGE_EXPSEL
  (
  .Ea(expA), 
  .Eb(expB), 
  .diff_sgn(expdiff_s1[8]), 
  .result_exp(sel_exp_s1)
  );
  
  comparator MANT_CMPR
  (
  .a(mantissaA), 
  .b(mantissaB), 
  .eq(mantissa_compare[0]) , 
  .gt(mantissa_compare[2]) , 
  .lt(mantissa_compare[1])
  );
  
  swap SWAP_MANT
  (
  .mantissa_A(mantissaA), 
  .mantissa_B(mantissaB), 
  .expdiff_sgn(expdiff_s1[8]), 
  .larger_mantissa(mant_lrgexp), 
  .smaller_mantissa(mant_smexp)
  );
  
  bit_inversion BIT_INV
  (
  .compare(mantissa_compare), 
  .eop(eop), 
  .exp_diff(actual_expdiff), 
  .op1_inv(opA_inv), 
  .op2_inv(opB_inv)
  );
  
  shifter #(.SHIFT_MODE(1), .STICKY_ENABLE(1), .NUM_SHIFT_BITS(8)) SMLLMANT_SHIFT
  (
  .mantissa({1'b1,mant_smexp}), 
  .mant_shift(actual_expdiff[7:0]), 
  .ovf(1'b0),
  .shift_dir(1'b1),
  .eop(eop),
  .shifted_mantissa(shifted_mant),
  .guard_bits_in(3'b000),
  .guard_bits_out(guard_bits_s1)
  );
  
  inversion_mux LRGEMANT_INV
  (
  .mantissa({1'b1, mant_lrgexp}), 
  .inversion_control(opA_inv), 
  .updated_mantissa(mantA_s1)
  );
  
  inversion_mux SMLLMANT_INV
  (
  .mantissa(shifted_mant), 
  .inversion_control(opB_inv), 
  .updated_mantissa(mantB_s1)
  ); 
    
  //Stage 2 Instantiations
  LOP_nbit LZC_PREDICT
  (
  .op1(reg_stage1[51:28]), 
  .op2(reg_stage1[27:4]),
  .eop(reg_stage1[75]), 
  .shift(lzc_shift)
  );
  
  CLA_24bit MANT_ADD
  (
  .a(reg_stage1[51:28]), 
  .b(reg_stage1[27:4]), 
  .carry_in(1'b0), 
  .carry_out(ovf), 
  .sum(adder_res)
  );
  
  //Stage 3 Instantiations
  shifter #(.SHIFT_MODE(0), .STICKY_ENABLE(0)) NORM_RESULT
  (
  .mantissa(reg_stage2[32:9]),
  .mant_shift({3'b000,reg_stage2[8:4]}), 
  .ovf(reg_stage2[56]), 
  .shift_dir(stage3_shift_dir), 
  .eop(reg_stage2[57]), 
  .shifted_mantissa(norm_res), 
  .guard_bits_in(reg_stage2[52:50]),
  .guard_bits_out(guard_bits_s3)
  );
  
  round ROUND_RES
  (
  .result({norm_res[22:0],guard_bits_s3}), 
  .rnd_result(prefinal_mantissa),
  .eop(reg_stage2[57])
  );
  
  Sign RESULT_SGN
  (
  .eop(reg_stage2[57]), 
  .signA(reg_stage2[59]), 
  .signB(reg_stage2[58]), 
  .operation(1'b1), 
  .expdiff(reg_stage2[49:41]), 
  .compare(reg_stage2[55:53]), 
  .signResult(sign_out)
  );
  
  exception_handling EXCPETIONS
  (
  .ovf(reg_stage2[56]), 
  .sel_exp(reg_stage2[40:33]), 
  .lzc_shift(reg_stage2[8:4]), 
  .norm_mant(prefinal_mantissa), 
  .mantissa(final_mantissa), 
  .exp(exp_out),
  .eop(reg_stage2[57])
  );
  
endmodule