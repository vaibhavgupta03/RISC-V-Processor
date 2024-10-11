module alu (
    input wire [31:0] operand_a,
    input wire [31:0] operand_b,
    input wire [3:0] alu_control,
    output reg [31:0] result,
    output wire zero_flag
);

// ALU Operation Codes
parameter ALU_ADD = 4'b0000;
parameter ALU_SUB = 4'b0001;
parameter ALU_AND = 4'b0010;
parameter ALU_OR  = 4'b0011;
parameter ALU_SLT = 4'b0100;  // Set Less Than

always @(*) begin
    case (alu_control)
        ALU_ADD: result = operand_a + operand_b;
        ALU_SUB: result = operand_a - operand_b;
        ALU_AND: result = operand_a & operand_b;
        ALU_OR:  result = operand_a | operand_b;
        ALU_SLT: result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0;
        default: result = 32'h0;
    endcase
end

assign zero_flag = (result == 32'h0);

endmodule