`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/02 15:48:34
// Design Name:
// Module Name: CPU_SC
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


module CPU_SC(
           input clk,
           output [10: 0] tempInstruction,
           output [63: 0] ALU_result,
           output [63: 0] data_mem_out,
           output [63: 0] pc
       );
// instruction memory
wire [31: 0] instruction;
reg tempInstruction;

// Register File
wire [63: 0] reg_data1;
wire [63: 0] reg_data2;
wire [63: 0] write_reg_data;
reg [4: 0] read_reg1;
wire [4: 0] read_reg2;
reg [4: 0] write_reg;
reg [4: 0] temp_reg_num1;
reg [4: 0] temp_reg_num2;
wire [63:0] data_out1;
wire [63:0] data_out2;

// ALU
wire ALU_result;
wire temp_ALU_zero;
wire [3: 0] temp_ALU_control;
wire [63: 0] temp_ALU_input2;
wire [63: 0] temp_immediate;
wire [63: 0] temp_shift_immediate;


// Data memory
wire data_mem_out;


// PC
reg pc;
wire [63: 0] next_pc;
wire [63: 0] next_next_pc;
wire [63: 0] shift_pc;
reg pc_jump; // nextpc | shift_pc
wire next_pc_zero;
wire shift_pc_zero;


// Control Unit
wire reg2loc;
wire reg_write;
wire mem_read;
wire mem_write;
wire branch;
wire mem2reg;
wire ALU_src;
reg uncon_branch;
wire [1: 0] ALU_op;
reg temp_branch_zero;

/* muxs */
mux2#(64) pcMUX(next_pc, shift_pc, pc_jump, next_next_pc);

mux2#(5) regMUX(temp_reg_num1, temp_reg_num2, reg2loc, read_reg2);

mux2#(64) ALUMUX(reg_data2, temp_immediate, ALU_src, temp_ALU_input2);

mux2#(64) dataMUX(data_mem_out, ALU_result, mem2reg, write_reg_data);

/* modules */
SignExtend Sign_Extend(instruction, temp_immediate);

ShiftLeft2 Shift_Left2(temp_immediate, temp_shift_immediate);

ALUControl ALU_Control(ALU_op, tempInstruction, temp_ALU_control);

/* ALU */
ALU ALUResult(reg_data1, temp_ALU_input2, temp_ALU_control, ALU_result, temp_ALU_zero);

ALU pcAdder(pc, 64'h00000004, 4'b0010, next_pc, next_pc_zero);

ALU sheftAdder(pc, temp_shift_immediate, 4'b0010, shift_pc, shift_pc_zero);

/* Control Unit */
ControlUnit Control_Unit(tempInstruction, reg2loc, ALU_src, mem2reg, reg_write, mem_read, mem_write, branch, ALU_op);

/* Data Memory */
dmem Data_Memory(ALU_result,data_out2,mem_read,mem_write,data_mem_out);

/* Instruction Memory */
imem Instruction_Memory(pc,instruction);

/* Register File */
RegisterFile Register_File(read_reg1,read_reg2,write_reg,write_reg_data,reg_write,data_out1,data_out2);

initial begin
    pc = 0;
    uncon_branch = 1'b0;
    temp_branch_zero = temp_ALU_zero & branch;
    pc_jump = uncon_branch | temp_branch_zero;
end

always@(clk or instruction) begin

    if (pc_jump == 1'b1) begin
        pc = #1 next_next_pc - 4;
    end

    temp_branch_zero = temp_ALU_zero & branch;
    pc_jump = uncon_branch | temp_branch_zero;

    if (pc_jump == 1'b0) begin
        pc <= #1 next_next_pc;
    end
end

endmodule
