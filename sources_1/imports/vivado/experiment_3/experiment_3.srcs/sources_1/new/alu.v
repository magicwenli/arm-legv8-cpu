`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/10/27 17:24:01
// Design Name:
// Module Name: alu
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


module ALU(
           input [63: 0] A,
           input [63: 0] B,
           input [3: 0] opt,
           output reg [63: 0] ans,
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

always@(A or B or opt) begin
    case (opt)
        A_AND:
            ans = A & B;
        A_OR:
            ans = A | B;
        A_ADD:
            ans = A + B;
        A_SUB:
            ans = A - B;
        A_PAS:
            ans = B;
        A_NOR:
            ans = ~(A | B);
    endcase

    if (ans == 0) begin
        zeroflag = 1'b1;
    end
    else begin
        zeroflag = 1'b0;
    end
end
endmodule
