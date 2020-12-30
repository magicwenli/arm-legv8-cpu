`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/01 20:35:43
// Design Name:
// Module Name: mux2
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


module mux2 #(parameter WIDTH = 5)
       (
           input [WIDTH - 1: 0] input1,
           input [WIDTH - 1: 0] input2,
           input signal,
           output reg [WIDTH - 1: 0] muxOutput
       );

always @(input1, input2, signal) begin

    if (signal == 0) begin
        muxOutput = input1;
    end
    else begin
        muxOutput = input2;
    end
end
endmodule
