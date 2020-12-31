//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:56:41
//  LastEditTime : 2020-12-31 16:03:17
//  Description  : ALU 控制器
//*****
`timescale 1ns / 1ps

module ALUControl
       (
           input [1: 0] ALUop,
           input [10: 0] opcode,
           output reg [3: 0] ALUout
       );

always @( * ) begin
    case (ALUop)
        2'b00 :
            ALUout = 4'b0010; // Jump instruction
        2'b01 :
            ALUout = 4'b0111;
        2'b10 :
        case (opcode)
            11'b10001011000 :
                ALUout = 4'b0010; // ADD
            11'b11001011000 :
                ALUout = 4'b0110; // SUB
            11'b10001010000 :
                ALUout = 4'b0000; // AND
            11'b10101010000 :
                ALUout = 4'b0001; // ORR
        endcase
    endcase
end
endmodule
