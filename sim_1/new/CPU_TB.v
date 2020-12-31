//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 17:00:31
//  LastEditTime : 2020-12-31 17:13:10
//  Description  : 
//*****
`timescale 1ns / 1ps 

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
wire REG2LOC;
wire REGWRITE;
wire MEMREAD;
wire MEMWRITE;
wire BRANCH;

imem InsMem(instructionPC, instructionOut);

dmem DataMem( ALU_Result_Out,
              DATA_OUT_2,
              MEMREAD,
              MEMWRITE,
              data_memory_out);

RegisterFile RegFile( READ_REG_1,
                      READ_REG_2,
                      WRITE_REG,
                      WRITE_DATA,
                      REGWRITE,
                      DATA_OUT_1,
                      DATA_OUT_2);

CPU_SC cpu(.CLOCK(CLOCK),
           .INSTRUCTION(instructionOut),
           .REG_DATA1(DATA_OUT_1),
           .REG_DATA2(DATA_OUT_2),
           .data_memory_out(data_memory_out),
           .READ_REG_1(READ_REG_1),
           .READ_REG_2(READ_REG_2),
           .WRITE_REG(writeReg),
           .ALU_Result_Out(ALU_Result_Out),
           .WRITE_REG_DATA(WRITE_DATA),
           .PC(instructionPC)
          );



initial begin
    clk = 1'b0;
    #30 $finish;
end

always begin
    #10 clk = ~clk;
end

endmodule
