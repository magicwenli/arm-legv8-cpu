`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 12:57:25
// Design Name: 
// Module Name: sram
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

module sram(
    input CE,OE,WE,CLK,
    input [7:0] AD,
    input [7:0] DIN,
    output [7:0] DOUT
    );
    reg [7:0] data_out;
    reg [7:0] DATA [0:255];
    
    assign DOUT=(OE&&CE&&!WE)?data_out:8'bz;
    always @(posedge CLK) begin
        if(OE&&CE&&!WE) // ������
            data_out= DATA[AD];
        if(WE&&CE)      // д����
            DATA[AD]=DIN;
    end
endmodule
