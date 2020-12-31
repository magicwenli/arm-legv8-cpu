//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:56:02
//  LastEditTime : 2020-12-31 16:18:22
//  Description  : 符号扩展单元
//*****
`timescale 1ns / 1ps

module SignExtend
       (
           input [31: 0] instruction_in,
           output reg [63: 0] out_immediate
       );

always @( * ) begin
    if (instruction_in[31: 26] == 6'b000101) begin // B
        out_immediate[25: 0] = instruction_in[25: 0];
        out_immediate[63: 26] = {63{out_immediate[25]}};

    end
    else if (instruction_in[31: 24] == 8'b10110100) begin // CBZ
        out_immediate[19: 0] = instruction_in[23: 5];
        out_immediate[63: 20] = {63{out_immediate[19]}};

    end
    else begin // D Type
        out_immediate[9: 0] = instruction_in[20: 12];
        out_immediate[63: 10] = {63{out_immediate[9]}};
    end
end
endmodule

