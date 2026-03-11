# Silicon-Sprint-SRM
SILICON SPRINT 2026, a National Level Digital Design Contest, in association with the  Mindgrove Technologies, Chennai &amp; IEEE SRM Student Branch

# 4×4 Systolic Array Matrix Multiplication using Verilog

## Project Description

This project implements a **4×4 systolic array** for matrix multiplication using Verilog HDL. The aim was to understand how parallel hardware architectures can speed up computation compared to sequential processing.

A systolic array works by passing data between small processing units in a synchronized manner. Each unit performs a multiply and accumulate operation, and together they compute the final matrix product.

The design was simulated and verified using a self-checking testbench and later synthesized to obtain timing, area, and power reports.

---

## Team Information

**Team ID:** SA-XXX
**Question Number:** QX

**Members**

* Keerthana G
* Member 2
* Member 3

---

## Design Overview

The system multiplies two 4×4 matrices:

```
C = A × B
```

The architecture is built using multiple **Processing Elements (PEs)** connected in stages.

Each PE:

* receives two inputs (`a` and `b`)
* multiplies them
* adds the result to a running partial sum
* forwards the updated sum to the next stage

To avoid unnecessary computation, multiplication happens only when both inputs are non-zero.

---

## Modules Used

### 1. Processing Element (PE)

The PE is the basic building block of the design.
It performs the multiply-accumulate operation on every clock cycle.

Main operation:

```
sum_out = sum_in + (a * b)
```

---

### 2. Systolic Array (4×4)

The top module connects multiple PEs using Verilog `generate` loops.
Each output element is calculated through four accumulation stages corresponding to matrix multiplication steps.

---

### 3. Testbench

A self-checking testbench is implemented to verify correctness.

The testbench:

* generates clock and reset
* assigns matrix values
* computes expected results internally
* compares hardware output with reference values
* displays **TEST PASSED** or mismatch messages automatically

---

## Folder Structure

```
project/
│
├── rtl/
│   ├── PE.v
│   └── systolic_array_4x4.v
│
├── testbench/
│   └── tb.v
│
├── synthesis_reports/
│   ├── timing.rpt
│   ├── area.rpt
│   └── power.rpt
│
└── README.md
```

---

## Simulation Steps

Run simulation using Cadence Xcelium:

```
xrun -gui systolic_array_4x4.v tb.v
```

Waveforms can be viewed in SimVision.

---

## Synthesis Steps

Run synthesis using Cadence Genus:

```
genus -files synth.tcl
```

Generated outputs include:

* Timing report
* Area report
* Power report
* Synthesized netlist

---

## Design Details

| Feature           | Description             |
| ----------------- | ----------------------- |
| Array Size        | 4 × 4                   |
| Input Width       | 8 bits                  |
| Accumulator Width | 32 bits                 |
| Operation         | Multiply and Accumulate |
| Design Type       | Sequential (clocked)    |

---

## Observations

* Parallel computation significantly reduces computation time.
* Generate loops simplified hardware creation.
* Self-checking testbench helped quickly verify correctness.
* The systolic structure makes scaling to larger arrays possible.

---

## Applications

* Neural network accelerators
* DSP systems
* Image processing hardware
* AI inference engines

---

## Tools Used

* Verilog HDL
* Cadence Xcelium (Simulation)
* Cadence Genus (Synthesis)
* GitHub

---

## Conclusion

This project helped in understanding how matrix multiplication can be implemented efficiently in hardware using systolic architectures. It also provided practical experience with RTL design, verification, and synthesis flow used in VLSI design.

---
