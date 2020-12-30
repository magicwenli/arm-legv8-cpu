`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/27 12:36:03
// Design Name: 
// Module Name: adder
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


module adder(
    input A,
    input B,
    input Ci,
    output S,
    output Co
    );
    wire C1,C2,S1;
    
    hadder h1(A,B,C1,S1);
    hadder h2(S1,Ci,C2,S);
    assign Co=C1&C2;
endmodule
