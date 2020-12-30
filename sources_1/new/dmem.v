`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/19 17:52:17
// Design Name:
// Module Name: dmem
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


module dmem(
           input [63: 0] addr,
           input [63: 0] idata,
           input mreadsig,
           input mwritesig,
           output reg [63: 0] odata
       );

reg [63: 0]memory[31: 0];

integer datanum;

initial begin
    for (datanum = 0; datanum < 32; datanum = datanum + 1) begin
        memory[datanum] = datanum * 100;
    end

    memory[10] = 1540;
    memory[11] = 2117;
end

always @(addr, idata, mreadsig, mwritesig) begin
    if (mwritesig == 1) begin
        memory[addr] = idata;
    end

    if (mreadsig == 1) begin
        odata = memory[addr];
    end
end
endmodule
