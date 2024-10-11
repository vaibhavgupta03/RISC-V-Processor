module program_counter (
    input wire clk,
    input wire rst,
    input wire [31:0] pc_next,
    output reg [31:0] pc_current
);

always @(posedge clk or posedge rst) begin
    if (rst)
        pc_current <= 32'h0;
    else
        pc_current <= pc_next;
end

endmodule