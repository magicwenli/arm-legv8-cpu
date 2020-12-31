//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:56:23
//  LastEditTime : 2020-12-31 16:20:00
//  Description  : ALU
//*****
`timescale 1ns / 1ps

module ALU(
           input [63: 0] A,
           input [63: 0] B,
           input [3: 0] CONTROL,
           output reg [63: 0] RESULT,
           output reg zeroflag
       );

parameter	A_AND = 4'b0000;
parameter	A_OR = 4'b0001;
parameter	A_ADD = 4'b0010;
parameter	A_SUB = 4'b0110;
parameter	A_PAS = 4'b0111;
parameter	A_NOR = 4'b1100;

// wire Co;
// wire [31: 0] tmpans;
// wire Ci = 1'b0;
// adder32 a1(A, B, Ci, tmpans, Co);

always@(A or B or CONTROL) begin
    case (CONTROL)
        A_AND:
            RESULT = A & B;
        A_OR:
            RESULT = A | B;
        A_ADD:
            RESULT = A + B;
        A_SUB:
            RESULT = A - B;
        A_PAS:
            RESULT = B;
        A_NOR:
            RESULT = ~(A | B);
    endcase

    if (RESULT == 0) begin
        zeroflag = 1'b1;
    end
    else begin
        zeroflag = 1'b0;
    end
end
endmodule
