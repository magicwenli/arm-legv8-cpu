//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:54:08
//  LastEditTime : 2020-12-31 16:10:45
//  Description  : 寄存器文件
//*****
`timescale 1ns / 1ps 

module RegisterFile(
           input[4: 0] rreg1,             // read register 1
           input[4: 0] rreg2,             // read register 2
           input[4: 0] wreg,              // write register
           input[63: 0] wdata,            // write data
           input REGWRITE,               // write signal
           output reg [63: 0]rdata1,      // read data 1
           output reg [63: 0]rdata2      // read data 2
       );

reg [63: 0] Data[31: 0];

integer regnum;

// 初始化寄存器的数值 从0到30
initial begin

    for (regnum = 0; regnum < 31; regnum = regnum + 1) begin
        Data[regnum] = regnum;
    end

    Data[31] = 64'h00000000;
end

always @(rreg1, rreg2, wreg, wdata, REGWRITE) begin

    rdata1 = Data[rreg1];
    rdata2 = Data[rreg2];

    if (REGWRITE == 1) begin
        Data[wreg] = wdata;
    end
end
endmodule
