//General Shifter of mantissa for aligning exponents in Stage 1 and Normalizing Result in Stage 3
 //Shift Direction protocol - 1 for right shift and -1 for left shif
module shifter #(
  NUM_SHIFT_BITS = 8,
  STICKY_ENABLE = 1, //1 for calculating sticky and  0 for not calculating
  SHIFT_MODE = 0 //Stage 1 for 0 and Stage 3(normalization) for 1
  )
  (
    input wire [23:0] mantissa,
    input wire [NUM_SHIFT_BITS - 1:0] mant_shift,
    input wire ovf,
    input wire eop,
    input wire shift_dir,
    input wire [2:0] guard_bits_in,
    output logic [23 :0] shifted_mantissa, 
    output logic [2:0] guard_bits_out
  );

  integer index, i;
  logic [0 : 4][4 : 0] pos_shift;
  //logic [1 : 24] [23 : 0] shifted_mantissa_mux; 
  //logic [23 : 0] interim_shift; 
  logic [7 : 0] shift;
  logic eff_shift;
  assign pos_shift = {5'b00001,5'b00010, 5'b00100, 5'b01000, 5'b10000};
      
  always_comb begin
    guard_bits_out = guard_bits_in;
    if(STICKY_ENABLE) begin
      eff_shift = (eop)? mant_shift : ((mant_shift > 2)? {1'b0, mant_shift} - 2 : 0);
      if(eff_shift > 0) begin
        for(index = 0; index < eff_shift; index++) begin
          guard_bits_out[0] = guard_bits_out[0] | mantissa[index];
        end
      guard_bits_out[2:1] = eop? 2'b00 : ((mant_shift > 1)?  {mantissa[mant_shift - 1], mantissa[mant_shift - 2]} : {mantissa[mant_shift - 1], 1'b0});
    end
      if(!eop) begin
        eff_shift = (mant_shift > 2)? 0 : mant_shift - 3; 
       for(index = 2; index >= 0; index--) begin
         guard_bits_out[index] = !guard_bits_out[index];
      end
      guard_bits_out = guard_bits_out + 1;
    end
    end
    else if(ovf && !SHIFT_MODE) begin
      guard_bits_out[2] = guard_bits_in[2] | guard_bits_in[1];
      guard_bits_out[1] = guard_bits_in[0];
      guard_bits_out[0] = mantissa[23]; 
    end
  end   
  
  always_comb begin
    shifted_mantissa = mantissa;
    if(mant_shift > 23)
      shifted_mantissa = '0;
    else if(!eop || SHIFT_MODE) begin
    for(i = 0; i < 5; i++) begin
      if(mant_shift[i] == 1)
        shifted_mantissa = (shift_dir == 1) ? shifted_mantissa >> pos_shift[i]:
                                              shifted_mantissa << pos_shift[i];
    end 
      shifted_mantissa = (mant_shift >= 3)? {shifted_mantissa[23 : 3], guard_bits_in} : ((mant_shift == 2)? {shifted_mantissa[23 : 2], guard_bits_in[2:1]} : ((mant_shift == 1)? {shifted_mantissa[23 : 1], guard_bits_in[2]} : shifted_mantissa));
    end
    else if(ovf)
      shifted_mantissa = {1'b1, mantissa[23:1]};
 end
endmodule
        