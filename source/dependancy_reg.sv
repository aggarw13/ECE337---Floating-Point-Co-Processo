// $Id: $
// File name:   dependancy_reg.sv
// Created:     4/7/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: a regester list to store the state of the current depednancvoid dependancy problems

module dependancy_reg
#(
  parameter numReg = 16
)
(
  input wire clk,// clock signal
  input wire n_rst, //reset
  input wire [numReg -1:0]dependency_set, //inputs to set the dependancies
  input wire [numReg -1:0]dependency_remove, //iputs to remove dependancies
  output reg [numReg -1:0]dependency_exists //the output back to the user
);

//reg [numReg -1 :0]dependency; // this is the actual regesters
reg [numReg -1:0]nxt_dependency;
genvar i;

always_ff @(posedge clk, negedge n_rst)
begin
  if (n_rst ==0)
    begin
      dependency_exists <= '0;
    end
  else
    begin 
      dependency_exists <= nxt_dependency;
    end
  end
  
generate
  for (i =0; i< numReg; i=i+1)
  begin
    always_comb
    begin
      if (dependency_set[i])
        nxt_dependency[i] = 1; //remove the dependency if it is set
      else if (dependency_remove[i])
        nxt_dependency[i] = 0; // set the dependency for the next set
      else
        nxt_dependency[i] = dependency_exists[i]; //keep the dependency the same
    end
  end
  
  
        
endgenerate
  

endmodule
