module instruction_memory (
    input wire [31:0] pc,
    output wire [31:0] instruction
);

reg [31:0] memory [0:1023]; // 1024 words of 32-bit instructions

initial begin
    // Load program into memory
    $readmemh("program.hex", memory);
end

assign instruction = memory[pc[11:2]]; // Word-aligned access

endmodule