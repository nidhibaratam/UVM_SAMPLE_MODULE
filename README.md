# UVM_SAMPLE_MODULE
UVM sample module based on a Synchronous FIFO RTL Design.
This Verilator-optimized project demonstrates a high-performance class-based verification environment for a Synchronous FIFO buffer. It features a complete UVM-style hierarchy including a randomized Driver, a Monitor-ready Interface with clocking blocks, and an automated Scoreboard with a golden reference model.

## Installing
To prepare the environment for simulation ensure Verilator 5.030+ and C++ build tools are installed
```bash
python3 -m pip install verilator  # Or use your distribution's package manager
```
---
# How to use
For a quick test of the verification environment:

## Make the automated build script executable
```bash
chmod +x run.sh
```

## Build and execute the simulation binary
```bash
./run.sh
```
## View the generated timing diagrams
```bash
gtkwave waveform.vcd
```
---
# Documentation
For more info, read the generated Transaction Log in the terminal or examine the SystemVerilog TikZ Architecture Diagram for component mapping.
