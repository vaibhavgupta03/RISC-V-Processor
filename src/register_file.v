module register_file (
    input wire clk,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire reg_write,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);

reg [31:0] registers [0:31];

// Initialize registers
integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        registers[i] = 32'h0;
end

// Write operation
always @(posedge clk) begin
    if (reg_write && write_reg != 5'b0)
        registers[write_reg] <= write_data;
end

// Read operations
assign read_data1 = (read_reg1 == 5'b0) ? 32'h0 : registers[read_reg1];
assign read_data2 = (read_reg2 == 5'b0) ? 32'h0 : registers[read_reg2];

endmodule