`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/03 13:31:54
// Design Name:
// Module Name: CPU_TB
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


module CPU_TB();

reg clk;
wire [10: 0] tempInstruction;
wire [63: 0] ALU_result;
wire [63: 0] data_mem_out;
wire [63: 0] pc;

CPU_SC cpu(clk, tempInstruction, ALU_result, data_mem_out, pc);


initial begin
    clk = 1'b0;
//    #30 $finish;
end

always begin
    #10 clk = ~clk;
end

endmodule
