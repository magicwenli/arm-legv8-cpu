//*****
//  Author       : magicwenli
//  Date         : 2021-01-05 13:49:51
//  LastEditTime : 2021-01-05 14:05:23
//  Description  : FSM
//*****

`timescale 1ns / 1ps

module FSM(
           input CLOCK,
           input [3: 0] STATE,
           input [63: 0] INSTRUCTION,
           output reg [3: 0] NSTATE，
           output reg CONTROL_REG2LOC = 1'b0,
           output reg CONTROL_MEM2REG = 1'b0,
           output reg CONTROL_REGWRITE = 1'b0,
           output reg CONTROL_MEMREAD = 1'b0,
           output reg CONTROL_MEMWRITE = 1'b0,
           output reg CONTROL_ALUSRC = 1'b0,
           output reg [1: 0] CONTROL_ALU_OP = 2'b01,
           output reg CONTROL_BRANCH = 1'b0,
           output reg CONTROL_UNCON_BRANCH = 1'b1
       );

initial begin
    NSTATE = 1001;
    CONTROL_REG2LOC = 
end


endmodule