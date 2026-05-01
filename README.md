## 32 bit ALU- RTL-DFT Flow**
A complete Design for Testability (DFT) flow for a 32-bit ALU. This project feature RTL Design and simulation via Icarus Verilog. Yosys based synthesis  and  featuring custom scan chain insertion and ATPG using the open-source Fault tool.

## Key Features & Specifications
* **Supported Operations:** Addition, Subtraction, AND, OR, XOR, and NAND.
* **Logic Synthesis:** Mapped to the SCL 180nm library, resulting in a chip area of 23,679 with 710 total cells.
* **Static Timing Analysis (STA):** Constrained with a 10ns clock period, generating SDF delays for accurate gate-level simulation.
* **DFT & ATPG:** 
  * Successfully constructed an internal scan chain of 33 flip-flops and a boundary scan chain of 101 cells (Total length: 134).
  * Achieved **90.21% Fault Coverage** .
  * Compacted 500 initial test vectors down to 31 essential vectors (86% compaction ratio).

## Tools Used

| Stage | Tool |
| :--- | :--- |
| **RTL Editing** | GVIM |
| **RTL Simulation** | Icarus Verilog |
| **Waveform Viewer** | GTKWave |
| **Synthesis** | Yosys 0.9 |
| **Static Timing Analysis** | OpenSTA |
| **DFT / Scan Insertion / ATPG** | Fault Tool |
| **Technology Library** | OSU018 / SCL 180nm (tsl18fs120) |

### Supported Operations

| `sel` Signal | Operation |
| :--- | :--- |
| `3'b000` | Addition (`a + b`) |
| `3'b001` | Subtraction (`a - b`) |
| `3'b010` | Bitwise AND |
| `3'b011` | Bitwise OR |
| `3'b100` | Bitwise XOR |
| `3'b101` | Bitwise NAND |

##  Repository Structure
alu32-rtl-to-gds/
│
├── rtl/
│   ├── ALU_32.v                              # RTL design
│   └── alu_tb_32.v                           # Testbench
│
├── synthesis/
│   ├── alu_syn.ys                            # Yosys synthesis script
│   └── alu_netlist.v                         # Gate-level netlist
│
├── sta/
│   ├── alu.sdc                               # Timing constraints
│   ├── runsta.tcl                            # OpenSTA script
│   └── delay_sdf.sdf                         # SDF timing file
│
├── dft/
│   ├── scan_config.yaml                      # Fault scan configuration
│   ├── replace_scan_ff.py                    # dfcrq1 -> sdnrq1(scanned flip flop) replacement script
│   ├── alu_scanned.v.chain-intermediate.v    # Fault intermediate output
│   ├── alu_scanned_final.v                   # Final scan-inserted netlist
│   ├── comb.v                                # Combinational netlist for ATPG
│   ├── test_vector.json                      # ATPG test vectors
│   ├── alu_test_vectors.bin                  # Assembled input vectors
│   └── alu_golden_output.bin                 # Expected output vectors
│
└── README.md

**Project Flow**
┌─────────────────────────────────────────────────────────────────────────────┐
│ RTL Design (ALU_32.v)                                                       │
│       |                                                                     │
│       ▼                                                                     │
│ RTL Simulation ────────── Icarus Verilog + GTKWave                          │
│       |                                                                     │
│       ▼                                                                     │
│ Synthesis ─────────────── Yosys + OSU018 liberty                            │
│       |                   731 cells, 33 FFs, Chip area: 10565.36units²       │
│       |                                                                     │
│       ▼                                                                     │
│ Gate Level Simulation ─── Icarus Verilog (with stdcell models)              │
│       |                                                                     │
│       ▼                                                                     │
│ Static Timing Analysis ── OpenSTA + SDC constraints                         │
│       |                   Generates delay_sdf.sdf                           │
│       |                                                                     │
│       ▼                                                                     │
│ SDF Back-annotated Simulation ── Icarus Verilog + SDF                       │
│       |                                                                     │
│       ▼                                                                     │
│ DFT — Scan Chain Insertion ────── Fault Tool                                │
│       |    fault chain → 33 internal FFs + 101 boundary cells (total: 134)  │
│       |    fault cut   → combinational design extraction                    │
│       |    fault atpg  → 2463 fault sites, 97.56% coverage, 40 test vectors │
│       |    fault asm   → assembled binary test vectors                      │
│       |                                                                     │
|
└─────────────────────────────────────────────────────────────────────────────┘
