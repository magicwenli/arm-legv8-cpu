//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:52:07
//  LastEditTime : 2020-12-31 16:08:29
//  Description  : 64位 2路选择器  5位 2路选择器
//*****
`timescale 1ns / 1ps

module mux2_64(
           input [63: 0] input1,
           input [63: 0] input2,
           input signal,
           output reg [63: 0] muxOutput
       );

always @( input1，input2，signal, muxOutput ) begin

    if (signal == 0) begin
        muxOutput = input1;
    end
    else begin
        muxOutput = input2;
    end
end
endmodule


module mux2_5(
        input [5: 0] input1,
        input [5: 0] input2,
        input signal,
        output reg [5: 0] muxOutput
    );

always @( input1, input2, signal ) begin

    if (signal == 0) begin
        muxOutput = input1;
    end
    else begin
        muxOutput = input2;
    end
end
endmodule
