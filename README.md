# UVM_SAMPLE_MODULE

A **Verilator-optimized** UVM-style verification environment for a **Synchronous FIFO RTL Design**. This project demonstrates a high-performance, class-based testbench featuring a randomized Driver, Monitor-ready interfaces with clocking blocks, and an automated Scoreboard with a golden reference model.

## Key Features
*   **Class-Based Architecture:** Modular UVM-style hierarchy for scalability.
*   **Automated Verification:** Self-checking Scoreboard compares RTL against a reference model.
*   **High Performance:** Optimized for Verilator 5.0+ simulation speeds.
*   **Visibility:** Generates standard VCD files for waveform analysis.

---

## Installation

Ensure you have **Verilator 5.030+** and standard C++ build tools installed.

```bash
# Install Verilator via pip or your distribution's package manager
python3 -m pip install verilator
```
## How to Use
1. Build and Execute
Run the automated build script to compile the RTL and testbench:
```bash
chmod +x run.sh
./run.sh
```

2. Analyze Results
View the generated timing diagrams to debug signal transitions:
```bash
gtkwave waveform.vcd
```

3. Run with Custom Seeds
To test with different randomized sequences, pass a specific seed to the binary:
```bash
./obj_dir/Vtop +verilator+seed+$RANDOM
```

