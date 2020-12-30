`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/27 12:25:45
// Design Name: 
// Module Name: adder32
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


module adder32copy(
    input [31:0] dA,
    input [31:0] dB,
    input Ci,
    output [31:0] dS,
    output Co
    );
    assign dS[0]=Ci;
    assign dS[1]=dA[0]&dB[0]|(dA[0]^dB[0]&dS[0]);
    assign dS[2]=dA[1]&dB[1]|(dA[1]^dB[1]&dS[1]);
    assign dS[3]=dA[2]&dB[2]|(dA[2]^dB[2]&dS[2]);
    assign dS[4]=dA[3]&dB[3]|(dA[3]^dB[3]&dS[3]);
    assign dS[5]=dA[4]&dB[4]|(dA[4]^dB[4]&dS[4]);
    assign dS[6]=dA[5]&dB[5]|(dA[5]^dB[5]&dS[5]);
    assign dS[7]=dA[6]&dB[6]|(dA[6]^dB[6]&dS[6]);
    assign dS[8]=dA[7]&dB[7]|(dA[7]^dB[7]&dS[7]);
    assign dS[9]=dA[8]&dB[8]|(dA[8]^dB[8]&dS[8]);
    assign dS[10]=dA[9]&dB[9]|(dA[9]^dB[9]&dS[9]);
    assign dS[11]=dA[10]&dB[10]|(dA[10]^dB[10]&dS[10]);
    assign dS[12]=dA[11]&dB[11]|(dA[11]^dB[11]&dS[11]);
    assign dS[13]=dA[12]&dB[12]|(dA[12]^dB[12]&dS[12]);
    assign dS[14]=dA[13]&dB[13]|(dA[13]^dB[13]&dS[13]);
    assign dS[15]=dA[14]&dB[14]|(dA[14]^dB[14]&dS[14]);
    assign dS[16]=dA[15]&dB[15]|(dA[15]^dB[15]&dS[15]);
    assign dS[17]=dA[16]&dB[16]|(dA[16]^dB[16]&dS[16]);
    assign dS[18]=dA[17]&dB[17]|(dA[17]^dB[17]&dS[17]);
    assign dS[19]=dA[18]&dB[18]|(dA[18]^dB[18]&dS[18]);
    assign dS[20]=dA[19]&dB[19]|(dA[19]^dB[19]&dS[19]);
    assign dS[21]=dA[20]&dB[20]|(dA[20]^dB[20]&dS[20]);
    assign dS[22]=dA[21]&dB[21]|(dA[21]^dB[21]&dS[21]);
    assign dS[23]=dA[22]&dB[22]|(dA[22]^dB[22]&dS[22]);
    assign dS[24]=dA[23]&dB[23]|(dA[23]^dB[23]&dS[23]);
    assign dS[25]=dA[24]&dB[24]|(dA[24]^dB[24]&dS[24]);
    assign dS[26]=dA[25]&dB[25]|(dA[25]^dB[25]&dS[25]);
    assign dS[27]=dA[26]&dB[26]|(dA[26]^dB[26]&dS[26]);
    assign dS[28]=dA[27]&dB[27]|(dA[27]^dB[27]&dS[27]);
    assign dS[29]=dA[28]&dB[28]|(dA[28]^dB[28]&dS[28]);
    assign dS[30]=dA[29]&dB[29]|(dA[29]^dB[29]&dS[29]);
    assign dS[31]=dA[30]&dB[30]|(dA[30]^dB[30]&dS[30]);
    assign Co=dA[30]&dB[30]|(dA[30]^dB[30]&dS[30]);
endmodule
