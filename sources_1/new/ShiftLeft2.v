//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:50:39
//  LastEditTime : 2020-12-31 15:51:54
//  Description  : 左移2位
//*****
`timescale 1ns / 1ps

module ShiftLeft2
       (
           input [63: 0] inputData,
           output reg [63: 0] outputData
       );

always @( inputData ) begin
    outputData = inputData << 2;
end
endmodule
