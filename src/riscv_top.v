module riscv_top (
    input wire clk,
    input wire rst
);

// Internal signals
wire [31:0] pc_current, pc_next, instruction;
wire [31:0] reg_write_data, read_data1, read_data2;
wire [31:0] alu_result, immediate, data_memory_out;
wire [3:0] alu_control;
wire zero_flag, branch, mem_write, mem_to_reg, alu_src, reg_write;
wire [1:0] alu_op;

// Program Counter
program_counter pc_module (
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc_current(pc_current)
);

// Instruction Memory
instruction_memory instr_mem (
    .pc(pc_current),
    .instruction(instruction)
);

// Register File
register_file reg_file (
    .clk(clk),
    .read_reg1(instruction[19:15]),
    .read_reg2(instruction[24:20]),
    .write_reg(instruction[11:7]),
    .write_data(reg_write_data),
    .reg_write(reg_write),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// ALU
alu alu_module (
    .operand_a(read_data1),
    .operand_b(alu_src ? immediate : read_data2),
    .alu_control(alu_control),
    .result(alu_result),
    .zero_flag(zero_flag)
);

// Control Unit
control_unit ctrl_unit (
    .opcode(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .alu_op(alu_op),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .branch(branch)
);

// Immediate Generator
immediate_gen imm_gen (
    .instruction(instruction),
    .immediate(immediate)
);

// Data Memory
data_memory data_mem (
    .clk(clk),
    .address(alu_result),
    .write_data(read_data2),
    .mem_write(mem_write),
    .read_data(data_memory_out)
);

// Next PC calculation
assign pc_next = pc_current + ((branch & zero_flag) ? immediate : 32'd4);

// Write back
assign reg_write_data = mem_to_reg ? data_memory_out : alu_result;

endmodule