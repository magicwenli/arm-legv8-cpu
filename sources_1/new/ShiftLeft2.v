`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/02 15:34:53
// Design Name:
// Module Name: ALUControl
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module ShiftLeft2
       (
           input [63: 0] inputData,
           output reg [63: 0] outputData
       );

always @( * ) begin
    outputData = inputData << 2;
end
endmodule
