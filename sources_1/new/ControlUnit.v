`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/02 15:25:00
// Design Name:
// Module Name: ControlUnit
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


module ControlUnit(
           input clk,
           input [10: 0] instruction_in,
           output reg reg2Loc,
           output reg ALUsrc,
           output reg mem2Reg,
           output reg regWrite,
           output reg memRead,
           output reg memWrite,
           output reg branch,
           output reg [1: 0] ALUop,
           output reg unconBranch
       );

initial begin
    reg2Loc = 1'bz;
    ALUsrc = 1'bz;
    mem2Reg = 1'bz;
    regWrite = 1'bz;
    memRead = 1'bz;
    memWrite = 1'bz;
    branch = 1'b0;
    unconBranch = 1'b0;
end

always @( posedge clk or instruction_in ) begin
    if (instruction_in[10: 5] == 6'b000101) begin // Control bits for B
        reg2Loc = 0;
        ALUsrc = 0;
        mem2Reg = 0;
        regWrite = 0;
        memRead = 0;
        memWrite = 0;
        branch = 0;
        ALUop = 01;
        unconBranch = 1'b1;
    end
    else if (instruction_in[10: 3] == 8'b10110100) begin // Control bits for CBZ
        reg2Loc = 0;
        ALUsrc = 0;
        mem2Reg = 0;
        regWrite = 0;
        memRead = 0;
        memWrite = 0;
        branch = 1;
        ALUop = 01;
        unconBranch = 1'b0;
    end
    else begin
        branch=0;
        unconBranch=0;

        case (instruction_in)
            'b11111000010: begin             //Load
                // reg2Loc = x;
                ALUsrc = 1;
                mem2Reg = 1;
                regWrite = 1;
                memRead = 1;
                memWrite = 0;
                ALUop = 00;
            end
            'b11111000000: begin	            //Store
                reg2Loc = 1;
                ALUsrc = 1;
                regWrite = 0;
                memRead = 0;
                memWrite = 1;
                // mem2Reg = x;
                ALUop = 00;
            end
            'b10001011000,
            'b11001011000,
            'b10001010000,
            'b10101010000: begin               //R-Type (ADD, SUB, AND, ORR)
                reg2Loc = 0;
                ALUsrc = 0;
                mem2Reg = 0;
                regWrite = 1;
                memRead = 0;
                memWrite = 0;
                branch = 0;
                ALUop = 10;
            end

            default: begin
                reg2Loc = 1'h0;
                ALUsrc = 1'h0;
                mem2Reg = 1'h0;
                regWrite = 1'h0;
                memRead = 1'h0;
                memWrite = 1'h0;
                branch = 1'h0;
                ALUop = 2'h0;
            end
        endcase
    end
end
endmodule
