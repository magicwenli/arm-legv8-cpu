//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 17:00:31
//  LastEditTime : 2021-01-05 00:28:34
//  Description  :
//*****
`timescale 1ns / 1ps

module CPU_TB();

/* Clock Signal */
reg CLOCK;

/* Wires to connect instruction memory to CPU */
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

CPU_SC cpu( .CLOCK(CLOCK),
            .INSTRUCTION(instructionOut),
            .PC(instructionPC),
            .CONTROL_REG2LOC(CONTROL_REG2LOC),
            .CONTROL_REGWRITE(CONTROL_REGWRITE),
            .CONTROL_MEMREAD(CONTROL_MEMREAD),
            .CONTROL_MEMWRITE(CONTROL_MEMWRITE),
            .CONTROL_BRANCH(CONTROL_BRANCH),
            .READ_REG_1(READ_REG_1),
            .READ_REG_2(READ_REG_2),
            .WRITE_REG(WRITE_REG),
            .REG_DATA1(DATA_OUT_1),
            .REG_DATA2(DATA_OUT_2),
            .ALU_Result_Out(ALU_Result_Out),
            .data_memory_out(data_memory_out),
            .WRITE_REG_DATA(WRITE_DATA)
          );



initial begin
    CLOCK = 1'b0;
    #300 $finish;
end

always begin
    #10 CLOCK = ~CLOCK;
end

endmodule
