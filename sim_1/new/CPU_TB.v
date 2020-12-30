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
wire [63: 0] instructionPC;
wire [31: 0] instructionOut;

/* Wires to connect registers to CPU */
wire [4: 0] READ_REG_1;
wire [4: 0] READ_REG_2;
wire [4: 0] WRITE_REG;
wire [63: 0] WRITE_DATA;
wire [63: 0] DATA_OUT_1;
wire [63: 0] DATA_OUT_2;

/* Wires to connect Data Memory to CPU */
wire [63: 0] data_memory_out;
wire [63: 0] ALU_Result_Out;

/* Wires to connect CPU Control Lines to Memories */
wire CONTROL_REG2LOC;
wire CONTROL_REGWRITE;
wire CONTROL_MEMREAD;
wire CONTROL_MEMWRITE;
wire CONTROL_BRANCH;

imem InsMem(instructionPC, instructionOut);

dmem DataMem( ALU_Result_Out,
              DATA_OUT_2,
              CONTROL_MEMREAD,
              CONTROL_MEMWRITE,
              data_memory_out);

RegisterFile RegFile( READ_REG_1,
                      READ_REG_2,
                      WRITE_REG,
                      WRITE_DATA,
                      CONTROL_REGWRITE,
                      DATA_OUT_1,
                      DATA_OUT_2);

CPU_SC cpu(clk, ALU_Result_Out, data_memory_out, instructionPC);



initial begin
    clk = 1'b0;
    //    #30 $finish;
end

always begin
    #10 clk = ~clk;
end

endmodule
