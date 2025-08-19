# Vending Machine Controller (Mealy FSM)

## 📌 Overview
The machine accepts coins of **₹5** and **₹10**, represented by a 2-bit input:

- `coin = 2'b01` → ₹5  
- `coin = 2'b10` → ₹10  
- `coin = 2'b00` → No coin  
- `coin = 2'b11` → Ignore  

The FSM determines when to **dispense the product** and if it needs to **return ₹5 change**.

---

## ⚡ Why Mealy?
This controller is designed as a **Mealy FSM** (not Moore) because:

- Outputs depend on **both state and current input** → faster response.  
- Product is dispensed **immediately when the final coin is inserted** (no extra cycle).  
- In contrast, a Moore FSM would delay dispensing by one clock cycle.  

✅ Mealy FSM ensures **efficient, real-time dispensing**.

---

## 🔑 State Encoding
| State | Meaning           |
|-------|------------------|
| S0    | ₹0 inserted      |
| S1    | ₹5 inserted      |
| S2    | ₹10 inserted     |
| S3    | ₹15 inserted     |

---

## 🔄 State Transitions
- **From S0**  
  - +₹5 → S1  
  - +₹10 → S2  

- **From S1**  
  - +₹5 → S2  
  - +₹10 → S3  

- **From S2**  
  - +₹5 → S3  
  - +₹10 → Dispense → Reset to S0  

- **From S3**  
  - +₹5 → Dispense → Reset to S0  
  - +₹10 → Dispense + Return ₹5 change → Reset to S0  

---

## 💡 Output Logic
- **Dispense** → when total ≥ ₹20  
- **Change (chg5)** → when ₹25 is inserted (S3 + ₹10)  

---

## 🖥️ Simulation Commands
```bash
iverilog -o vending vending_fsm.v tb_vending.v
vvp vending
gtkwave wave_vending.vcd
