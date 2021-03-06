// $Id: $
// File name:   dependency_remove.sv
// Created:     4/23/2015
// Author:      James Alliger
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: A block that takes in result regesters an concadinates them into a 16 wide result

module dependency_remove
  #(
  parameter NUM_BLOCKS = 8
  )
(
  input wire [NUM_BLOCKS-1:0][3:0]result_address,// inputs from the blocks
  input wire [NUM_BLOCKS -1:0]remove_enable, //the enable of the remove dependecy
  output reg [15:0]dependency_remove //this is the output to the scheduler
  
);
reg [3:0]i;

always_comb
  begin
    dependency_remove = '0;
  for (i = 0; i< NUM_BLOCKS; i=i+1)
    begin
      if (remove_enable[i])
        dependency_remove[result_address[i]] = 1;
      end
      
end
endmodule 

