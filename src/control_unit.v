module control_unit (
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [1:0] alu_op,
    output reg mem_write,
    output reg mem_to_reg,
    output reg alu_src,
    output reg reg_write,
    output reg branch
);

// Opcodes
parameter R_TYPE = 7'b0110011;
parameter I_TYPE = 7'b0010011;
parameter LW     = 7'b0000011;
parameter SW     = 7'b0100011;
parameter BRANCH = 7'b1100011;

always @(*) begin
    case (opcode)
        R_TYPE: begin
            alu_op = 2'b10;     // R-type ALU operation
            mem_write = 1'b0;   // No memory write
            mem_to_reg = 1'b0;  // ALU result to register
            alu_src = 1'b0;     // Use register as second operand
            reg_write = 1'b1;   // Write result to register
            branch = 1'b0;      // Not a branch instruction
        end
        I_TYPE: begin
            alu_op = 2'b10;     // I-type ALU operation
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b1;     // Use immediate as second operand
            reg_write = 1'b1;
            branch = 1'b0;
        end
        LW: begin
            alu_op = 2'b00;     // Add for address calculation
            mem_write = 1'b0;
            mem_to_reg = 1'b1;  // Memory to register
            alu_src = 1'b1;
            reg_write = 1'b1;
            branch = 1'b0;
        end
        SW: begin
            alu_op = 2'b00;
            mem_write = 1'b1;   // Write to memory
            mem_to_reg = 1'bx;  // Don't care
            alu_src = 1'b1;
            reg_write = 1'b0;   // No register write
            branch = 1'b0;
        end
        BRANCH: begin
            alu_op = 2'b01;     // Branch comparison
            mem_write = 1'b0;
            mem_to_reg = 1'bx;
            alu_src = 1'b0;
            reg_write = 1'b0;
            branch = 1'b1;      // Branch instruction
        end
        default: begin
            alu_op = 2'b00;
            mem_write = 1'b0;
            mem_to_reg = 1'b0;
            alu_src = 1'b0;
            reg_write = 1'b0;
            branch = 1'b0;
        end
    endcase
end

endmodule