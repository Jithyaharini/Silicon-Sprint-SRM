# Silicon-Sprint-SRM
SILICON SPRINT 2026, a National Level Digital Design Contest, in association with the  Mindgrove Technologies, Chennai &amp; IEEE SRM Student Branch

# 🚀 4×4 Systolic Array Matrix Multiplier (Verilog HDL)

## 📌 Project Overview

This project implements a **4×4 Systolic Array architecture** for matrix multiplication using **Verilog HDL**. The design demonstrates parallel hardware computation using interconnected Processing Elements (PEs) that perform synchronized multiply–accumulate operations.

The system multiplies two 4×4 matrices and produces a 4×4 output matrix using pipelined data flow, similar to architectures used in modern AI accelerators and digital signal processors.

---

## 👥 Team Information

Team ID: 46
**Question Number:** 02

**Team Members**

* Jithyaharini N
* Keerthana G

---

## 🎯 Design Objectives

* Implement a hardware-based matrix multiplication engine
* Design reusable Processing Elements (PE)
* Build scalable systolic architecture
* Verify correctness using a self-checking testbench
* Perform synthesis and analyze timing, area, and power

---

## 🧠 Systolic Array Concept

A systolic array consists of multiple Processing Elements arranged in a grid where data flows rhythmically between neighbors.

### Key Characteristics

* Parallel computation
* Local data reuse
* Pipeline execution
* Deterministic timing

Each clock cycle propagates operands across the array while partial sums accumulate progressively.

---

## 🏗️ Architecture Description

### Processing Element (PE)

Each PE performs:

* Multiply operation: `a × b`
* Accumulation with incoming partial sum
* Conditional computation enable logic

```
sum_out = sum_in + (a * b)
```

Computation occurs only when inputs are non-zero to reduce unnecessary switching activity.

---

### 4×4 Systolic Array

The top module connects multiple PEs using Verilog `generate` loops:

* Rows correspond to matrix **A**
* Columns correspond to matrix **B**
* Pipeline stages perform accumulation

Matrix multiplication implemented:

```
C[i][j] = Σ A[i][k] × B[k][j]
```

---

## 📂 Repository Structure

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
│   ├── area.rpt
│   ├── timing.rpt
│   └── power.rpt
│
├── images/
│   └── waveform.png
│
└── README.md
```

---

## 🧪 Verification Methodology

A **self-checking testbench** is implemented.

### Features

* Automatic clock generation
* Reset sequencing
* Reference matrix multiplication model
* Expected output computation
* Automatic mismatch detection
* Pass/Fail reporting

Simulation prints:

```
TEST PASSED
```

when outputs match expected results.

---

## ▶️ Running Simulation (Cadence Xcelium)

```bash
xrun -gui rtl/systolic_array_4x4.v testbench/tb.v
```

Waveforms can be analyzed using **SimVision**.

---

## ⚙️ Synthesis Flow (Cadence Genus)

```bash
genus -files synth.tcl
```

Generated outputs:

* Timing Report
* Area Report
* Power Report
* Synthesized Netlist

---

## 📊 Design Specifications

| Parameter         | Value                     |
| ----------------- | ------------------------- |
| Architecture      | 4×4 Systolic Array        |
| Data Width        | 8-bit inputs              |
| Accumulator Width | 32-bit                    |
| Operations        | Multiply-Accumulate (MAC) |
| Clocked Design    | Yes                       |
| Verification      | Self-checking testbench   |

---

## 🚀 Key Features

* Parameterized PE-based architecture
* Generate-loop hardware construction
* Parallel matrix computation
* Automatic verification
* Hardware-efficient accumulation
* Scalable design concept

---

## 💡 Applications

* Neural Network Accelerators
* AI/ML Hardware Engines
* Digital Signal Processing
* Image Processing
* Edge AI Systems

---

## 📈 Results

The systolic architecture achieves:

* High computational parallelism
* Reduced control complexity
* Predictable pipeline latency
* Efficient hardware utilization

Refer to synthesis reports for detailed metrics.

---

## 🛠 Tools Used

* Verilog HDL
* Cadence Xcelium (Simulation)
* Cadence Genus (Synthesis)
* GitHub Version Control

---

## 📜 License

This repository is created for academic and competition purposes.

---

## ✨ Acknowledgement

This project demonstrates practical implementation of systolic computing architectures inspired by modern hardware accelerators used in AI processors.

