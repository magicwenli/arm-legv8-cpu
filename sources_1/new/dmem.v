//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:55:32
//  LastEditTime : 2020-12-31 16:16:44
//  Description  : 数据内存
//*****
`timescale 1ns / 1ps 

module dmem(
           input [63: 0] addr,
           input [63: 0] idata,
           input MEMREAD,
           input MEMWRITE,
           output reg [63: 0] odata
       );

reg [63: 0]Data[31: 0];

integer datanum;

// 初始化 数据内存
initial begin
    for (datanum = 0; datanum < 32; datanum = datanum + 1) begin
        Data[datanum] = datanum * 100;
    end

    Data[10] = 1540;
    Data[11] = 2117;
end

always @(addr, idata, MEMREAD, MEMWRITE) begin
    if (MEMWRITE == 1) begin
        Data[addr] = idata;
    end

    if (MEMREAD == 1) begin
        odata = Data[addr];
    end
end
endmodule
