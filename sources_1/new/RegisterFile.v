`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/01 19:40:12
// Design Name:
// Module Name: RegisterFile
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


module RegisterFile(
           input[4: 0] rreg1,             // read register 1
           input[4: 0] rreg2,             // read register 2
           input[4: 0] wreg,              // write register
           input[63: 0] wdata,            // write data
           input regwrite,               // write signal
           output reg [63: 0]rdata1,      // read data 1
           output reg [63: 0]rdata2      // read data 2
       );

reg [63: 0] registers[31: 0];

integer regnum;

initial begin

    for (regnum = 0; regnum < 31; regnum = regnum + 1) begin
        registers[regnum] = regnum;
    end

    registers[31] = 64'h00000000;
end

always @(rreg1, rreg2, wreg, wdata, regwrite) begin

    rdata1 = registers[rreg1];
    rdata2 = registers[rreg2];

    if (regwrite == 1) begin
        registers[wreg] = wdata;
    end
end
endmodule
