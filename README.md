# ASIC Craps Game: RTL, Synthesis, Physical Design, and STA

This repository presents an ASIC implementation flow for a Verilog-based craps/dice game controller.  
The design was implemented as a finite state machine (FSM), verified using simulation, synthesized using Synopsys Design Compiler, physically implemented through floorplanning, power planning, placement, and CTS, and analyzed using PrimeTime STA.

> **Note:** The available screenshots document RTL verification, synthesis, physical design up to CTS, and STA hold fixing. Raw PDK files, standard-cell libraries, tool databases, DEF/GDS files, and confidential setup files are not included.

## Project Objective

The objective of this project is to design and verify a dice-based game controller and take it through a basic ASIC design flow.

The game logic follows standard craps-style rules:

- If the initial dice sum is **7 or 11**, the game asserts `win`.
- If the initial dice sum is **2, 3, or 12**, the game asserts `lose`.
- Otherwise, the first dice sum is stored as the `point`.
- During later rolls, matching the stored `point` gives a win.
- Rolling a `7` during the point phase gives a loss.

## Design Flow

| Stage | Tool / Environment | Output |
|---|---|---|
| RTL Design | Verilog | FSM-based dice game controller |
| Functional Verification | ModelSim | Simulation waveform and output validation |
| Logic Synthesis | Synopsys Design Compiler | Gate-level netlist and timing/area/power reports |
| Physical Design | Synopsys ICC2 | Design import, floorplan, power plan, placement, CTS |
| Static Timing Analysis | Synopsys PrimeTime | Hold violation analysis and buffer-based timing fix |

## RTL Architecture

The design uses a simple datapath and controller structure:

- Dice inputs: `dice1`, `dice2`
- Adder to compute dice sum
- Test logic for initial win/loss detection
- Point register to store the intermediate point value
- Comparator for point-phase checking
- Controller FSM for game state transitions

![Block Architecture](images/01_block_architecture.png)

## FSM

The controller has three main states:

| State | Function |
|---|---|
| `s0` | Reset/idle state, waits for roll |
| `s1` | Checks initial roll for immediate win/loss or stores point |
| `s2` | Checks later rolls against point or seven-out condition |

![FSM Diagram](images/02_fsm_diagram.png)

## RTL Structural View

![RTL Architectural View](images/03_rtl_architectural_view.png)

## Functional Simulation

The RTL was verified using a testbench that applies multiple dice combinations to check immediate win, immediate loss, point establishment, and later point comparison behavior.

![Simulation Waveform](images/04_simulation_waveform.png)

## Synthesis Results

The design was synthesized using Synopsys Design Compiler. Timing, area, and power report screenshots are included below.

| Report | Screenshot |
|---|---|
| Timing | `images/05_synthesis_timing_report.png` |
| Area | `images/06_synthesis_area_report.png` |
| Power | `images/07_synthesis_power_report.png` |

### Timing Report

![Synthesis Timing](images/05_synthesis_timing_report.png)

### Area Report

![Synthesis Area](images/06_synthesis_area_report.png)

### Power Report

![Synthesis Power](images/07_synthesis_power_report.png)

## Physical Design Flow

The physical design flow includes design import, floorplanning, power planning, placement, and CTS.

### Design Import

![Design Import](images/08_design_import_view.png)

### Floorplan

![Floorplan](images/09_floorplan_view.png)

### Power Plan

![Power Plan](images/10_powerplan_view.png)

### Placement

Before legalization:

![Placement Before Legalization](images/11_place_before_legalization.png)

After legalization:

![Placement After Legalization](images/12_place_after_legalization.png)

### Clock Tree Synthesis

![CTS View](images/13_cts_view.png)

## Static Timing Analysis and Hold Fix

PrimeTime STA was used to analyze timing. Initial analysis showed hold violations. Buffer insertion was applied on violating paths, and the final constraint report shows no remaining violations.

| STA Step | Observation |
|---|---|
| Initial STA | Hold violations observed |
| Debug | Violating path inspected in GUI |
| Fix | Buffer insertion applied |
| Final Check | No violations reported |

### Hold Violations Before Fix

![Hold Violations Before Fix](images/14_sta_hold_violations_before_fix.png)

### Example Violated Path

![Violated Path Example](images/15_sta_violated_path_example.png)

### Path After Buffer Fix

![Path After Buffer Fix](images/16_sta_path_after_buffer_fix.png)

### No Violations After Fix

![No Violations After Fix](images/17_sta_no_violations_after_fix.png)

### Check Timing

![Check Timing](images/18_sta_check_timing.png)

## Repository Structure

```text
asic-craps-game-rtl-physical-design/
├── README.md
├── .gitignore
├── rtl/
│   └── dice_game.v
├── tb/
│   └── dg_tb.v
├── images/
│   ├── 01_block_architecture.png
│   ├── 02_fsm_diagram.png
│   ├── 03_rtl_architectural_view.png
│   ├── 04_simulation_waveform.png
│   ├── 05_synthesis_timing_report.png
│   ├── 06_synthesis_area_report.png
│   ├── 07_synthesis_power_report.png
│   ├── 08_design_import_view.png
│   ├── 09_floorplan_view.png
│   ├── 10_powerplan_view.png
│   ├── 11_place_before_legalization.png
│   ├── 12_place_after_legalization.png
│   ├── 13_cts_view.png
│   ├── 14_sta_hold_violations_before_fix.png
│   ├── 15_sta_violated_path_example.png
│   ├── 16_sta_path_after_buffer_fix.png
│   ├── 17_sta_no_violations_after_fix.png
│   └── 18_sta_check_timing.png
├── reports/
│   ├── synthesis_summary.md
│   ├── physical_design_summary.md
│   └── sta_summary.md
└── docs/
    └── project_notes.md
```

## Tools Used

- Verilog HDL
- ModelSim
- Synopsys Design Compiler
- Synopsys ICC2
- Synopsys PrimeTime

## Notes

This repository is intended as a clean portfolio version of the project. It intentionally excludes:

- PDK files
- Standard-cell library files
- Liberty/LEF/GDS/database files
- Tool-generated work directories
- License/server information
- Confidential setup files
