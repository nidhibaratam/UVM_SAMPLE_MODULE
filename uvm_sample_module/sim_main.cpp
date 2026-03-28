#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};
    
    while (!contextp->gotFinish()) {
        top->eval();
    }
    
    top->final();
    delete top;
    delete contextp;
    return 0;
}
