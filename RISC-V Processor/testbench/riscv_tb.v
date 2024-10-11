module riscv_tb;
    reg clk;
    reg rst;
    
    // Instantiate the top module
    riscv_top dut (
        .clk(clk),
        .rst(rst)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test stimulus
    initial begin
        // Reset
        rst = 1;
        #10 rst = 0;
        
        // Run for some cycles
        #1000;
        
        // End simulation
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("riscv_test.vcd");
        $dumpvars(0, riscv_tb);
    end
    
    // Monitor important signals
    always @(posedge clk) begin
    $display("Time=%0t PC=%h Instruction=%h", 
             $time, dut.pc_current, dut.instruction);
    $display("Registers: x1=%h x2=%h x3=%h x4=%h",
             dut.reg_file.registers[1],
             dut.reg_file.registers[2],
             dut.reg_file.registers[3],
             dut.reg_file.registers[4]);
    end
endmodule