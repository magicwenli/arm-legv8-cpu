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


module imem(
           input [63: 0] pc,
           output reg [31: 0] instruction
       );

reg [7: 0] memory [63: 0];
reg [5: 0] n;
initial begin
    $readmemh("instructions.txt", memory);
end

always @(pc) begin
    instruction[7: 0] = memory[pc + 3];
    instruction[15: 8] = memory[pc + 2];
    instruction[23: 16] = memory[pc + 1];
    instruction[31: 24] = memory[pc];

    $display("instructions: %h",instruction);
end
endmodule

    // module test ();
    // reg [63:0] pc=64'h00000000;
    // wire [31:0] op;

    // imem t1(pc,op);


    // endmodule
