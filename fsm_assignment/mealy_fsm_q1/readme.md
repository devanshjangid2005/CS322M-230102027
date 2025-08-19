# Sequence Detector — 1101 (Mealy FSM with Overlap)

## Design Specs
- **FSM Type**: Mealy  
- **Sequence Detected**: `1101`  
- **Reset**: Synchronous, Active-High  
- **Output (`y`)**: 1-cycle pulse when the final `1` of `1101` arrives  
- **Overlap**: Supported  

---

## Input Test Stream
- din = 110111011011011011011001101111101101
- y = 000100010010010010010000001000001001

---

## Detection Indices
The sequence `1101` is detected at bit positions: 
3, 7, 10, 13, 16, 19, 26, 32, 35


---

## Simulation

### Compile & Run
```bash
iverilog -o sub_mealy seq_mealy_fsm.v tb_mealy.v
vvp seb_mealy
gtkwave wave_mealy.vcd
