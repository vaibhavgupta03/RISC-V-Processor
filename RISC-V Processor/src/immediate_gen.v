module immediate_gen (
    input wire [31:0] instruction,
    output reg [31:0] immediate
);

wire [6:0] opcode = instruction[6:0];

always @(*) begin
    case (opcode)
        7'b0010011: immediate = {{20{instruction[31]}}, instruction[31:20]}; // I-type
        7'b0000011: immediate = {{20{instruction[31]}}, instruction[31:20]}; // Load
        7'b0100011: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // Store
        7'b1100011: immediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // Branch
        default: immediate = 32'h0;
    endcase
end

endmodule