//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:54:41
//  LastEditTime : 2020-12-31 16:56:37
//  Description  : CPU 主文件
//*****
`timescale 1ns / 1ps

module CPU_SC( input CLOCK,
               input [31: 0] INSTRUCTION,
               input [63: 0] REG_DATA1,
               input [63: 0] REG_DATA2,
               input [63: 0] data_memory_out,
               output reg [4: 0] READ_REG_1,
               output [4: 0] READ_REG_2,
               output reg [4: 0] WRITE_REG,
               output [63: 0] ALU_Result_Out,
               output [63: 0] WRITE_REG_DATA,
               output reg [63: 0] PC
             );

reg REG2LOC;
reg REGWRITE;
reg MEMREAD;
reg MEMWRITE;
reg BRANCH;
reg MEM2REG;
reg ALUSRC;
reg UNCON_BRANCH;
reg [1: 0] ALU_OP;

wire [63: 0] nextPC;
wire [63: 0] shiftPC;
wire [63: 0] nextnextPC;
reg [4: 0] tempRegNum1;
reg [4: 0] tempRegNum2;
wire [63: 0] tempImmediate;
wire [63: 0] tempALUInput2;
wire [63: 0] tempShiftImmediate;
reg [10: 0] tempInstruction;
wire [3: 0] tempALUControl;
wire tempALUZero;
wire nextPCZero;
wire shiftPCZero;

/* muxs */
mux2_64 pcMUX(nextPC, shiftPC, JUMP, nextnextPC);
mux2_5 regMUX(tempRegNum1, tempRegNum2, REG2LOC, READ_REG_2);
mux2_64 ALUMUX(REG_DATA2, tempImmediate, ALU_SRC, tempALUInput2);
mux2_64 dataMUX(data_memory_out, ALU_Result_Out, MEM2REG, WRITE_REG_DATA);

/* Control Unit */
ControlUnit Control_Unit(CLOCK,
                         INSTRUCTION,
                         nextnextPC,
                         tempALUZero,
                         REG2LOC,
                         REGWRITE,
                         MEMREAD,
                         MEMWRITE,
                         BRANCH,
                         MEM2REG,
                         ALUSRC,
                         UNCON_BRANCH,
                         JUMP,
                         ALU_OP,
                         READ_REG_1,
                         WRITE_REG,
                         PC);
/* modules */
SignExtend Sign_Extend(INSTRUCTION, tempImmediate);
ShiftLeft2 Shift_Left2(tempImmediate, tempShiftImmediate);

/* ALU Control*/
ALUControl ALU_Control(ALU_OP, tempInstruction, tempALUControl);

/* ALU */
ALU ALUResult(REG_DATA1, tempALUInput2, tempALUControl, ALU_Result_Out, temp_ALU_zero);
ALU pcAdder(PC, 64'h00000004, 4'b0010, nextPC, nextPC_zero);
ALU sheftAdder(PC, tempShiftImmediate, 4'b0010, shiftPC, shiftPCZero);

endmodule
