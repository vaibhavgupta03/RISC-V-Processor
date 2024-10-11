module data_memory (
    input wire clk,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire mem_write,
    output wire [31:0] read_data
);

reg [31:0] memory [0:1023]; // 1024 words of 32-bit memory

always @(posedge clk) begin
    if (mem_write)
        memory[address[11:2]] <= write_data;
end

assign read_data = memory[address[11:2]];

endmodule