# RVX10-Pipeline: A 5-Stage Pipelined RISC-V Core

[![ISA-RISCV](https://img.shields.io/badge/ISA-RISC--V%20(RV32I)-blue.svg)](https://riscv.org)
[![Language-SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange.svg)](https://www.systemverilog.io/)

This repository contains the design and implementation of **RVX10-Pipeline**, a 5-stage pipelined processor core that implements the 32-bit RISC-V base integer instruction set (RV32I). The core is enhanced with **RVX10**, a custom instruction set extension that adds 10 new ALU operations.

This project was developed as part of the **Digital Logic and Computer Architecture** course at **IIT Guwahati**, under the guidance of **Dr. Satyajit Das**.

---

## 🚀 Core Architecture

The RVX10-Pipeline processor elevates a basic single-cycle design into a high-throughput, five-stage pipelined architecture. By executing different stages of multiple instructions concurrently, it achieves significant instruction-level parallelism.

The classic five RISC stages are implemented:
1.  **IF** - Instruction Fetch
2.  **ID** - Instruction Decode & Register Fetch
3.  **EX** - Execute / Address Calculation
4.  **MEM** - Memory Access
5.  **WB** - Write Back

Execution integrity is maintained through dedicated pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB), which isolate each stage.



---

## ✨ Key Features

### ISA and Custom Extensions
- **RV32I Compliance**: Provides full support for the base RISC-V 32-bit integer instruction set.
- **RVX10 Custom Extension**: Integrates 10 novel ALU instructions to enhance computational capabilities:
  - `ANDN`, `ORN`, `XNOR` (Bitwise logical operations)
  - `MIN`, `MAX` (Signed minimum/maximum)
  - `MINU`, `MAXU` (Unsigned minimum/maximum)
  - `ROL`, `ROR` (Rotate left/right)
  - `ABS` (Absolute value)

### Hazard Management
A robust hazard management system is implemented to ensure correct program execution and data integrity:
- **Forwarding Unit**: Mitigates Read-After-Write (RAW) data hazards by forwarding results from the MEM and WB stages directly to the EX stage, eliminating unnecessary stalls.
- **Hazard Detection Unit**:
    - **Load-Use Hazards**: Detects dependencies on `lw` instructions and introduces a single-cycle stall (bubble) to ensure data is available before use.
    - **Control Hazards**: Flushes the IF and ID stages upon taking a branch or jump to discard incorrectly fetched instructions and redirect the Program Counter.
- **Branch Flush Logic**: Automatically injects NOPs into the pipeline after a control hazard to maintain a clean state.

### Performance and Verification
- **Low CPI**: Achieves an average **CPI (Cycles Per Instruction) of approximately 1.28** on benchmark programs, demonstrating high efficiency.
- **Functional Correctness**: Produces bit-for-bit identical results to the equivalent single-cycle processor. For the provided test program, it correctly writes the value **25** to memory address **100**.
- **`x0` Register Integrity**: The zero register (`x0`) is correctly hardwired to zero, as per the RISC-V specification.

---

## 🏗️ Architectural Block Diagram

The diagram below illustrates the high-level organization of the pipelined datapath and control units.

![Pipeline Diagram](https://github.com/user-attachments/assets/0296251d-c06e-440d-a48d-3899437b4aa2)

---

## 🛠️ Simulation and Setup

You can simulate the processor using either a commercial tool like Vivado or open-source simulators.

### Method 1: Simulating with Vivado
1.  Launch Vivado and create a new project.
2.  Add all SystemVerilog files (`.sv`) from the `/src` directory as **Design Sources**.
3.  Add the `tb_pipeline.sv` file from the `/tb` directory as a **Simulation Source**.
4.  Ensure the memory initialization file (`riscvtest.mem` or `rvx10_pipeline.hex`) is accessible to the project.
5.  Run a **Behavioral Simulation** to observe the processor's execution in the waveform viewer.

### Method 2: Simulating with Icarus Verilog / Verilator
1.  Ensure you have a SystemVerilog-compliant simulator like Icarus Verilog installed.
2.  Navigate to the project root and execute the following commands in your terminal:

```bash
# Compile the design and testbench
iverilog -g2012 -o pipeline_sim tb/tb_pipeline.sv src/*.sv

# Run the simulation executable
vvp pipeline_sim
```
---
## 📈 Observations
- Load-Use Hazard: One-cycle bubble verified.
- Forwarding: Correctly resolves RAW hazards.
- Branch Flush: IF/ID and ID/EX registers flushed on taken branch.
- Pipeline Overlap: Multiple instructions active each cycle (verified via waveforms).
---

## 📚 References

This project’s design and pipeline architecture are based on:

> **Digital Design and Computer Architecture (RISC-V Edition)**  
> *David Harris and Sarah Harris*  
> **CS322M – Digital Design and Computer Architecture**

---

## 👥 Contributors

### Project Author
* **Devansh Jangid**

### Project Supervisor
* **Dr. Satyajit Das** *Assistant Professor* Department of Computer Science and Engineering  
    Indian Institute of Technology, Guwahati
