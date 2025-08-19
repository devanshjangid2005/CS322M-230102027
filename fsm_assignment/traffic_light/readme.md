# Traffic Light Controller — Testbench (tb2.v)

## ⏱️ Clock & Tick Setup
- **Clock (clk)**
  - Period = **10 ns** (`always #5 clk = ~clk;`)
  - Frequency = **100 MHz**

- **Tick (tick)**
  - Divider counts **21 clock cycles** before asserting a tick.
  - Effective tick frequency:  
    ```
    TICK_HZ = 100 MHz / 21 ≈ 4.76 MHz
    ```
  - Faster tick chosen to make simulation **easier to visualize** (instead of a real-time 1 Hz).

---

## 🚦 Traffic Light Timing
The controller operates on a **5 / 2 / 5 / 2 tick sequence**:

| Phase        | Duration (ticks) |
|--------------|------------------|
| NS Green     | 5 |
| NS Yellow    | 2 |
| EW Green     | 5 |
| EW Yellow    | 2 |

This cycle repeats indefinitely.

---

## ✅ Verification
- Simulation observed in **GTKWave** (`wave2.vcd`).
- Behavior confirmed:
  - After reset → **NS Green** active for 5 ticks.
  - Transitioned to **NS Yellow** for 2 ticks.
  - Then to **EW Green** for 5 ticks.
  - Finally to **EW Yellow** for 2 ticks.
- The cycle repeated correctly → matching the expected **5/2/5/2 durations**.

---

## 🖥️ Simulation Commands
```bash
iverilog -o light traffic_light_fsm.v tb_light.v
vvp light
gtkwave wave_light.vcd
