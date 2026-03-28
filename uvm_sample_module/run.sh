# 1. Build the simulation
rm -rf obj_dir
rm -rf waveform.vcd
verilator --binary -j 0 --timing --trace -Wno-WIDTHTRUNC --top-module top fifo_uvm_pkg.sv fifo_if.sv fifo.sv top.sv


# 2. RUN the simulation
./obj_dir/Vtop
