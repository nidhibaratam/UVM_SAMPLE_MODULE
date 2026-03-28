class fifo_trans;
    rand logic [7:0] data;
    rand bit write_op;
endclass

class fifo_scoreboard;
    logic [7:0] model_q [$];
    logic [7:0] history [$]; // Stores all passed values for the final table
    bit last_rd_en = 0; 
    int pass_count = 0;
    int error_count = 0;

    function void check(logic wr, logic rd, logic [7:0] d_in, logic [7:0] d_out, bit full, bit empty);
        // 1. Handle Writes
        if (wr && !full) begin
            model_q.push_back(d_in);
            $display("[%0t] [DRV] Write Data: %h", $time, d_in);
        end

        // 2. Handle Reads
        if (last_rd_en) begin
            if (model_q.size() > 0) begin
                logic [7:0] expected = model_q.pop_front();
                if (d_out === expected) begin
                    $display("[%0t] [SCB] MATCH: Expected %h, Got %h", $time, expected, d_out);
                    history.push_back(d_out); 
                    pass_count++;
                end else begin
                    $display("[%0t] [SCB] MISMATCH: Expected %h, Got %h", $time, expected, d_out);
                    error_count++;
                end
            end
        end
        last_rd_en = (rd && !empty);
    endfunction

    function void report();
        $display("\n==========================================");
        $display("          FIFO TRANSACTION LOG");
        $display("==========================================");
        $display(" ID  |  Result  |  Data Value (Hex)");
        $display("-----|----------|-------------------------");
        foreach (history[i]) begin
            $display("%-4d |  PASS    |  0x%h", i+1, history[i]);
        end
        $display("==========================================");
        $display(" TOTAL PASSED: %0d", pass_count);
        $display(" TOTAL FAILED: %0d", error_count);
        $display("==========================================\n");
    endfunction
endclass

class fifo_driver;
    virtual fifo_if vif;
    function new(virtual fifo_if v); this.vif = v; endfunction

    task run();
        forever begin
            @(vif.drv_cb);
            vif.drv_cb.wr_en   <= ($urandom_range(0,9) < 6);
            vif.drv_cb.rd_en   <= ($urandom_range(0,9) < 4);
            vif.drv_cb.data_in <= 8'($urandom_range(0, 255));
        end
    endtask
endclass

class fifo_env;
    fifo_driver drv;
    fifo_scoreboard sb;
    function new(virtual fifo_if v);
        sb = new();
        drv = new(v);
    endfunction
endclass
