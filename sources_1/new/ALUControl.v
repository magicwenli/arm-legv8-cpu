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


module ALUControl
       (
           input [1: 0] ALUop,
           input [10: 0] opcode,
           output reg [3: 0] opt
       );

always @( * ) case (ALUop)
    2'b00 :
        opt = 4'b0010; // Jump instruction
    2'b01 :
        opt = 4'b0111;
    2'b10 :
    case (opcode)
        11'b10001011000 :
            opt = 4'b0010; // ADD
        11'b11001011000 :
            opt = 4'b0110; // SUB
        11'b10001010000 :
            opt = 4'b0000; // AND
        11'b10101010000 :
            opt = 4'b0001; // ORR
    endcase
endcase
endmodule
