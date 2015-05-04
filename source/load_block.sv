// Load Instruction Block
module load_block(
  input wire [31:0] operand,
  input wire enable,
  input wire clk,
  input wire nrst,
  input wire [3:0] dest_in,
  output wire [3:0] dest_out,
  output logic done,
  output logic [31:0] out_operand,
  output logic sram_load
  );
  
  reg [36:0] reg_in, reg_out;
  assign dest_out = reg_out[35:32];
  assign out_operand = reg_out[31:0];
  assign done = reg_out[36];
  assign sram_load = reg_in[36]; 
  
  always_ff @(posedge clk, negedge nrst) 
  begin
    if(nrst == 1'b0) begin
      reg_in <= '0;
      reg_out <= '0;
    end
    else begin
      reg_out <= reg_in; 
      reg_in <= {enable, dest_in, operand};
    end
  end 
endmodule