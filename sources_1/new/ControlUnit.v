//*****
//  Author       : magicwenli
//  Date         : 2020-12-31 15:55:49
//  LastEditTime : 2020-12-31 17:20:53
//  Description  : CU
//*****
`timescale 1ns / 1ps

module ControlUnit(
           input CLOCK,
           input [31: 0] INSTRUCTION,
           input [63: 0] nextnextPC,
           input tempALUZero,
           output reg REG2LOC,
           output reg REGWRITE,
           output reg MEMREAD,
           output reg MEMWRITE,
           output reg BRANCH,
           output reg MEM2REG,
           output reg ALUSRC,
           output reg UNCON_BRANCH,
           output reg JUMP,
           output reg [1: 0] ALU_OP,
           output reg [4: 0] READ_REG_1,
           output reg [4: 0] WRITE_REG,
           output reg [63: 0] PC,
           output reg [4: 0] tempRegNum1,
           output reg [4: 0] tempRegNum2,
           output reg [10: 0] tempInstruction
       );

reg tempBranchZero;

/* Initialize when the CPU is first run */
initial begin
    PC = 0;
    REG2LOC = 1'bz;
    MEM2REG = 1'bz;
    REGWRITE = 1'bz;
    MEMREAD = 1'bz;
    MEMWRITE = 1'bz;
    ALUSRC = 1'bz;
    BRANCH = 1'b0;
    UNCON_BRANCH = 1'b0;
    tempBranchZero = tempALUZero & BRANCH;
    JUMP = UNCON_BRANCH | tempBranchZero;
end

/* Parse and set the CPU's Control bits */
always @(posedge CLOCK or INSTRUCTION) begin

    // Set the PC to the jumped value
    if (JUMP == 1'b1) begin
        PC = #1 nextnextPC - 4;
    end

    // Parse the incoming instruction for a given PC
    tempInstruction = INSTRUCTION[31: 21];
    tempRegNum1 = INSTRUCTION[20: 16];
    tempRegNum2 = INSTRUCTION[4: 0];
    READ_REG_1 = INSTRUCTION[9: 5];
    WRITE_REG = INSTRUCTION[4: 0];

    if (INSTRUCTION[31: 26] == 6'b000101) begin // Control bits for B
        REG2LOC = 1'b0;
        MEM2REG = 1'b0;
        REGWRITE = 1'b0;
        MEMREAD = 1'b0;
        MEMWRITE = 1'b0;
        ALUSRC = 1'b0;
        ALU_OP = 2'b01;
        BRANCH = 1'b0;
        UNCON_BRANCH = 1'b1;

    end
    else if (INSTRUCTION[31: 24] == 8'b10110100) begin // Control bits for CBZ
        REG2LOC = 1'b0;
        MEM2REG = 1'b0;
        REGWRITE = 1'b0;
        MEMREAD = 1'b0;
        MEMWRITE = 1'b0;
        ALUSRC = 1'b0;
        ALU_OP = 2'b01;
        BRANCH = 1'b1;
        UNCON_BRANCH = 1'b0;

    end
    else begin // R-Type Control Bits

        BRANCH = 1'b0;
        UNCON_BRANCH = 1'b0;

        case (tempInstruction)
            11'b11111000010 : begin // Control bits for LDUR
                REG2LOC = 1'bx;
                MEM2REG = 1'b1;
                REGWRITE = 1'b1;
                MEMREAD = 1'b1;
                MEMWRITE = 1'b0;
                ALUSRC = 1'b1;
                ALU_OP = 2'b00;
            end

            11'b11111000000 : begin //Control bits for STUR
                // Control Bits
                REG2LOC = 1'b1;
                MEM2REG = 1'bx;
                REGWRITE = 1'b0;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b1;
                ALUSRC = 1'b1;
                ALU_OP = 2'b00;
            end

            11'b10001011000 : begin //Control bits for ADD
                REG2LOC = 1'b0;
                MEM2REG = 1'b0;
                REGWRITE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                ALUSRC = 1'b0;
                ALU_OP = 2'b10;
            end

            11'b11001011000 : begin //Control bits for SUB
                REG2LOC = 1'b0;
                MEM2REG = 1'b0;
                REGWRITE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                ALUSRC = 1'b0;
                ALU_OP = 2'b10;
            end

            11'b10001010000 : begin //Control bits for AND
                REG2LOC = 1'b0;
                MEM2REG = 1'b0;
                REGWRITE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                ALUSRC = 1'b0;
                ALU_OP = 2'b10;
            end

            11'b10101010000 : begin //Control bits for ORR
                REG2LOC = 1'b0;
                MEM2REG = 1'b0;
                REGWRITE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                ALUSRC = 1'b0;
                ALU_OP = 2'b10;
            end
        endcase
    end

    //Determine whether to branch
    tempBranchZero = tempALUZero & BRANCH;
    JUMP = UNCON_BRANCH | tempBranchZero;

    // For non-branch code, set the next sequential PC value
    if (JUMP == 1'b0) begin
        PC <= #1 nextnextPC;
    end
end
endmodule
