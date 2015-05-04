// Load Instruction Block
module move_block(
  input wire [31:0] operand,
  input wire enable,
  input wire clk,
  input wire nrst,
  input wire [3:0] dest_in,
  input wire [3:0] dest_out,
  output logic done,
  output logic [31:0] out_operand
  );
  
  //reg [35:0] reg_in, reg_out;
  reg [36:0] reg_in_out;
  assign dest_out = reg_in_out[35:32];
  assign out_operand = reg_in_out[31:0];
  assign done = reg_in_out[36];
  
  always_ff @(posedge clk, negedge nrst) 
  begin
    if(nrst == 1'b0) begin
      reg_in_out <= '0;
    end
    else begin
      reg_in_out <= {enable, dest_in, operand};
    end
  end 
endmodule