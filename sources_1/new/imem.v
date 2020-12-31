//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:55:05
//  LastEditTime : 2020-12-31 16:14:56
//  Description  : 指令内存
//*****
`timescale 1ns / 1ps 
// FIXME 位宽是9
module imem(
           input [63: 0] PC,
           output reg [31: 0] instruction
       );

reg [8: 0] memory [63: 0];
reg [5: 0] n;
initial begin
    $readmemh("instructions.txt", memory);
end

always @(PC) begin
    instruction[8: 0] = memory[PC + 3];
    instruction[16: 8] = memory[PC + 2];
    instruction[24: 16] = memory[PC + 1];
    instruction[31: 24] = memory[PC];

    $display("instructions: %h",instruction);
end
endmodule

