//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:54:41
//  LastEditTime : 2021-01-05 01:16:46
//  Description  : CPU 主文�?????
//*****
`timescale 1ns / 1ps

module CPU_SC( input CLOCK,
               input [31: 0] INSTRUCTION,
               input [63: 0] REG_DATA1,
               input [63: 0] REG_DATA2,
               input [63: 0] data_memory_out,
               output reg CONTROL_REG2LOC,
               output reg CONTROL_REGWRITE,
               output reg CONTROL_MEMREAD,
               output reg CONTROL_MEMWRITE,
               output reg CONTROL_BRANCH,
               output reg [4: 0] READ_REG_1,
               output [4: 0] READ_REG_2,
               output reg [4: 0] WRITE_REG,
               output [63: 0] ALU_Result_Out,
               output [63: 0] WRITE_REG_DATA,
               output reg [63: 0] PC
             );

reg [4: 0] tempRegNum1;
reg [4: 0] tempRegNum2;
reg [10: 0] tempInstruction;

reg CONTROL_MEM2REG;
reg CONTROL_ALUSRC;
reg CONTROL_UNCON_BRANCH;
reg [1: 0] CONTROL_ALU_OP;

wire tempALUZero;
wire[3: 0] tempALUControl;
wire[63: 0] tempALUInput2;
wire[63: 0] tempImmediate;
wire [63: 0] tempShiftImmediate;

wire [63: 0] nextnextPC;
reg CONTROL_JUMP;
wire [63: 0] nextPC;
wire nextPCZero;
wire [63: 0] shiftPC;
wire shiftPCZero;
reg tempBranchZero;

/* Multiplexer for the Program Counter */
mux2_64 PCMux(nextPC, shiftPC, CONTROL_JUMP, nextnextPC);

/* Multiplexer before the Register */
mux2_5 RegisterMux(tempRegNum1, tempRegNum2, CONTROL_REG2LOC, READ_REG_2);

/* Multiplexer before the ALU */
mux2_64 ALUMux(REG_DATA2, tempImmediate, CONTROL_ALUSRC, tempALUInput2);

/* Multiplexer after the Data memory */
mux2_64 DataMemMux( ALU_Result_Out ,data_memory_out, CONTROL_MEM2REG, WRITE_REG_DATA);

/* Sign Extention Module */
SignExtend SigExt(INSTRUCTION, tempImmediate);

/* Shift left by two module */
ShiftLeft2 ShLeft2(tempImmediate, tempShiftImmediate);

/* ALU Control for the ALU */
ALUControl ALUCtrl(CONTROL_ALU_OP, tempInstruction, tempALUControl);

/* ALU Result between the Registers and the Data Memory */
ALU AluResult(REG_DATA1, tempALUInput2, tempALUControl, ALU_Result_Out, tempALUZero);

/* An ALU module to calulcate the next sequential PC */
ALU PCAdder(PC, 64'h00000004, 4'b0010, nextPC, nextPCZero);

/* An ALU module to calulcate a shifted PC */
ALU PCShifter(PC, tempShiftImmediate, 4'b0010, shiftPC, shiftPCZero);


/* Initialize when the CPU is first run */
initial begin
    PC = 0;
    CONTROL_REG2LOC = 1'bz;
    CONTROL_MEM2REG = 1'bz;
    CONTROL_REGWRITE = 1'bz;
    CONTROL_MEMREAD = 1'bz;
    CONTROL_MEMWRITE = 1'bz;
    CONTROL_ALUSRC = 1'bz;
    CONTROL_BRANCH = 1'b0;
    CONTROL_UNCON_BRANCH = 1'b0;
    tempBranchZero = tempALUZero & CONTROL_BRANCH;
    CONTROL_JUMP = CONTROL_UNCON_BRANCH | tempBranchZero;
end

/* Parse and set the CPU's Control bits */
always @(posedge CLOCK or INSTRUCTION)begin


    // Parse the incoming instruction for a given PC
    tempInstruction = INSTRUCTION[31: 21];
    tempRegNum1 = INSTRUCTION[20: 16];
    tempRegNum2 = INSTRUCTION[4: 0];
    READ_REG_1 = INSTRUCTION[9: 5];
    WRITE_REG = INSTRUCTION[4: 0];

    if (INSTRUCTION[31: 26] == 6'b000101) begin // Control bits for B
        CONTROL_REG2LOC = 1'b0;
        CONTROL_MEM2REG = 1'b0;
        CONTROL_REGWRITE = 1'b0;
        CONTROL_MEMREAD = 1'b0;
        CONTROL_MEMWRITE = 1'b0;
        CONTROL_ALUSRC = 1'b0;
        CONTROL_ALU_OP = 2'b01;
        CONTROL_BRANCH = 1'b0;
        CONTROL_UNCON_BRANCH = 1'b1;

    end
    else if (INSTRUCTION[31: 24] == 8'b10110100) begin // Control bits for CBZ
        CONTROL_REG2LOC = 1'b0;
        CONTROL_MEM2REG = 1'b0;
        CONTROL_REGWRITE = 1'b0;
        CONTROL_MEMREAD = 1'b0;
        CONTROL_MEMWRITE = 1'b0;
        CONTROL_ALUSRC = 1'b0;
        CONTROL_ALU_OP = 2'b01;
        CONTROL_BRANCH = 1'b1;
        CONTROL_UNCON_BRANCH = 1'b0;

    end
    else begin // R-Type Control Bits

        CONTROL_BRANCH = 1'b0;
        CONTROL_UNCON_BRANCH = 1'b0;

        case (tempInstruction)
            11'b11111000010 : begin // Control bits for LDR
                CONTROL_REG2LOC = 1'bx;
                CONTROL_MEM2REG = 1'b1;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b1;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b1;
                CONTROL_ALU_OP = 2'b00;
            end

            11'b11111000000 : begin //Control bits for STR
                // Control Bits
                CONTROL_REG2LOC = 1'b1;
                CONTROL_MEM2REG = 1'bx;
                CONTROL_REGWRITE = 1'b0;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b1;
                CONTROL_ALUSRC = 1'b1;
                CONTROL_ALU_OP = 2'b00;
            end

            11'b10001011000 : begin //Control bits for ADD
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end

            11'b11001011000 : begin //Control bits for SUB
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end

            11'b10001010000 : begin //Control bits for AND
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end

            11'b10101010000 : begin //Control bits for ORR
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end
        endcase
    end

    //Determine whether to branch
    tempBranchZero = tempALUZero & CONTROL_BRANCH;
    CONTROL_JUMP = CONTROL_UNCON_BRANCH | tempBranchZero;

    // For non-branch code, set the next sequential PC value
    if (CONTROL_JUMP == 1'b0) begin
        PC <= #1 nextnextPC;
    end
    // Set the PC to the jumped value
    if (CONTROL_JUMP == 1'b1) begin
        PC = #1 nextnextPC;
    end
end

always @(posedge CLOCK) begin

    // Parse the incoming instruction for a given PC
    tempInstruction = INSTRUCTION[31: 21];
    tempRegNum1 = INSTRUCTION[20: 16];
    tempRegNum2 = INSTRUCTION[4: 0];
    READ_REG_1 = INSTRUCTION[9: 5];
    WRITE_REG = INSTRUCTION[4: 0];

    if (INSTRUCTION[31: 26] == 6'b000101) begin // Control bits for B
        CONTROL_REG2LOC = 1'b0;
        CONTROL_MEM2REG = 1'b0;
        CONTROL_REGWRITE = 1'b0;
        CONTROL_MEMREAD = 1'b0;
        CONTROL_MEMWRITE = 1'b0;
        CONTROL_ALUSRC = 1'b0;
        CONTROL_ALU_OP = 2'b01;
        CONTROL_BRANCH = 1'b0;
        CONTROL_UNCON_BRANCH = 1'b1;

    end
    else if (INSTRUCTION[31: 24] == 8'b10110100) begin // Control bits for CBZ
        CONTROL_REG2LOC = 1'b0;
        CONTROL_MEM2REG = 1'b0;
        CONTROL_REGWRITE = 1'b0;
        CONTROL_MEMREAD = 1'b0;
        CONTROL_MEMWRITE = 1'b0;
        CONTROL_ALUSRC = 1'b0;
        CONTROL_ALU_OP = 2'b01;
        CONTROL_BRANCH = 1'b1;
        CONTROL_UNCON_BRANCH = 1'b0;

    end
    else begin // R-Type Control Bits

        CONTROL_BRANCH = 1'b0;
        CONTROL_UNCON_BRANCH = 1'b0;

        case (tempInstruction)
            11'b11111000010 : begin // Control bits for LDR
                CONTROL_REG2LOC = 1'bx;
                CONTROL_MEM2REG = 1'b1;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b1;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b1;
                CONTROL_ALU_OP = 2'b00;
            end

            11'b11111000000 : begin //Control bits for STR
                // Control Bits
                CONTROL_REG2LOC = 1'b1;
                CONTROL_MEM2REG = 1'bx;
                CONTROL_REGWRITE = 1'b0;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b1;
                CONTROL_ALUSRC = 1'b1;
                CONTROL_ALU_OP = 2'b00;
            end

            11'b10001011000 : begin //Control bits for ADD
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end

            11'b11001011000 : begin //Control bits for SUB
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end

            11'b10001010000 : begin //Control bits for AND
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end

            11'b10101010000 : begin //Control bits for ORR
                CONTROL_REG2LOC = 1'b0;
                CONTROL_MEM2REG = 1'b0;
                CONTROL_REGWRITE = 1'b1;
                CONTROL_MEMREAD = 1'b0;
                CONTROL_MEMWRITE = 1'b0;
                CONTROL_ALUSRC = 1'b0;
                CONTROL_ALU_OP = 2'b10;
            end
        endcase
    end

    //Determine whether to branch
    tempBranchZero = tempALUZero & CONTROL_BRANCH;
    CONTROL_JUMP = CONTROL_UNCON_BRANCH | tempBranchZero;

    // For non-branch code, set the next sequential PC value
    if (CONTROL_JUMP == 1'b0) begin
        PC <= #1 nextnextPC;
    end
    
    // Set the PC to the jumped value
    if (CONTROL_JUMP == 1'b1) begin
        PC = #1 nextnextPC - 4;
    end
end
endmodule
