`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/02 15:39:08
// Design Name:
// Module Name: SignExtend
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


module SignExtend
       (
           input [31: 0] instruction_in,
           output reg [63: 0] instruction_ext
       );

always @( * ) begin
    if (instruction_in[31: 26] == 6'b000101) begin // B
        instruction_ext[25: 0] = instruction_in[25: 0];
        instruction_ext[63: 26] = {63{instruction_ext[25]}};

    end
    else if (instruction_in[31: 24] == 8'b10110100) begin // CBZ
        instruction_ext[19: 0] = instruction_in[23: 5];
        instruction_ext[63: 20] = {63{instruction_ext[19]}};

    end
    else begin // D Type
        instruction_ext[9: 0] = instruction_in[20: 12];
        instruction_ext[63: 10] = {63{instruction_ext[9]}};
    end
end
endmodule

