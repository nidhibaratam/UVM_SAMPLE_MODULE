`include "tb_classes.sv"

module top;
    logic clk;
    
    // 1. Clock Generation - MUST be simple for Verilator timing
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    fifo_if p_if(clk);
    fifo_env env;

    fifo dut (
        .clk(clk),
        .rst_n(p_if.rst_n),
        .data_in(p_if.data_in),
        .data_out(p_if.data_out),
        .wr_en(p_if.wr_en),
        .rd_en(p_if.rd_en),
        .full(p_if.full),
        .empty(p_if.empty)
    );

    initial begin
        // Trace Setup
        $dumpfile("waveform.vcd");
        $dumpvars(0, top);
        
        // --- Reset Phase ---
        p_if.rst_n = 0;
        p_if.wr_en = 0;
        p_if.rd_en = 0;
        
        // Wait for time to pass
        #50; 
        p_if.rst_n = 1;
        #10;

        // --- Environment Initialization ---
        env = new(p_if);
        
        // --- Start the Driver ---
        fork
            env.drv.run();
        join_none

        // --- Main Simulation Loop ---
        // Changed to wait for clock edges specifically
        repeat (200) begin
            @(posedge clk);
            // Small delay to ensure logic settles before checking
            #1; 
            env.sb.check(p_if.wr_en, p_if.rd_en, p_if.data_in, p_if.data_out, p_if.full, p_if.empty);
        end

        #100;
        env.sb.report(); 
        $display("--- SIMULATION FINISHED AT %0t ---", $time);
        $finish;
    end
endmodule
