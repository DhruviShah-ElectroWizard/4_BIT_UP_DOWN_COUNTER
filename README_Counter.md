# 4 BIT UP/DOWN COUNTER - RTL to GDSII FLOW
## Introduction
A counter is a type of sequential digital circuit that is used to count pulses or events in digital systems. It consists of a series of flip-flops connected in a specific sequence to generate a known counting pattern. Counters are essential components in various digital applications such as digital clocks, timers, frequency dividers, memory address generators, and control systems.

A 4-bit counter is capable of counting from 0000 (0 in decimal) to 1111 (15 in decimal), encompassing 16 distinct states. Each bit in the 4-bit binary output represents a power of 2, allowing the counter to represent decimal values ranging from 0 to 15.

### Truth Table
| Clock Edge | Reset | UP\_DOWN | Operation  | Output (Q3–Q0) |
| ---------- | ----- | -------- | ---------- | -------------- |
| Rising     | 1     | X        | Reset      | 0000           |
| Rising     | 0     | 1        | Count Up   | Q + 1          |
| Rising     | 0     | 0        | Count Down | Q - 1          |

The operation of a 4-bit up/down counter can be summarized as follows:

-The counter has four outputs: Q3, Q2, Q1, and Q0, representing a 4-bit binary number.

-A clock signal drives the counter's timing.

-A reset signal is often included to initialize the counter to a known state (typically zero).

-A direction control input determines whether the counter counts up or down.

### Circuit Diagram 
![image](https://github.com/user-attachments/assets/569533be-e3e7-4f62-9e8d-03282aac2675)

## Applications
- Digital clocks and watches

- Event counters

- Frequency measurement

- Memory address generation

- Control systems

- Elevator controllers

- Sequence generators

## Tools Used

### Design & Simulation
| Tool             | Purpose                                                             |
| ---------------- | ------------------------------------------------------------------- |
| **Verilog HDL**  | Hardware Description Language used to design the RTL of the counter |
| **Synopsys VCS** | Compiles and simulates Verilog code at RTL level                    |
| **Verdi**        | Waveform viewer for debugging simulation results                    |

### Synthesis 
| Tool                                                      | Purpose                                 |
| --------------------------------------------------------- | --------------------------------------- |
| **Synopsys Design Compiler (dc\_shell / dc\_shell-xg-t)** | Synthesizes RTL to gate-level netlist   |
| **Standard Design Cell Library (e.g., SAED32/45nm)**      | Target technology library for synthesis |

### Physical Design
| Tool                            | Purpose                                                                                      |
| ------------------------------- | -------------------------------------------------------------------------------------------- |
| **Synopsys ICC2 (icc2\_shell)** | Performs floorplanning, placement, CTS (Clock Tree Synthesis), routing, and GDSII generation |
| **start\_gui** (GUI command)    | Graphical interface for ICC2 and Design Compiler                                             |

### Timing and Power Analysis
| Tool                               | Purpose                                                     |
| ---------------------------------- | ----------------------------------------------------------- |
| **Synopsys PrimeTime (pt\_shell)** | Static timing and power analysis after synthesis and layout |

### Environment
| Tool            | Purpose                                                      |
| --------------- | ------------------------------------------------------------ |
| **Rocky Linux** | Operating system environment used for running Synopsys tools |

## Project Structure
```bash
counter_updown/
├── RTL_Verilog_Code/
│   └── counter_rtl.v
├── Testbench/
│   └── counter_tb.v
├── constraints/
│   └── counter.sdc
├── DC/
│   └── run_dc.tcl
├── ICC2/scripts/
│   ├── floorplan.tcl
│   ├── powerplan.tcl
│   ├── placement.tcl
│   ├── clock.tcl
│   ├── route.tcl
└── results/
    └── counter.mapped.v
```

## Key Commands and Usage 

###  Environment & Setup
```bash
which vcs
which verdi
which dc_shell
which icc2_shell
which pt_shell
```
✔️ Verifies if Synopsys tools are correctly installed and in your system path.
```bash
verdi
icc2_shell
dc_shell
start_gui
```
✔️ Launches Verdi, ICC2 shell, Design Compiler shell, or graphical user interface.

###  RTL Simulation (Using VCS & Verdi)
```bash
vcs -full64 RTL_Verilog_Code/counter_rtl.v -debug_access+all -lca -kdb
```
✔️ Compiles the counter RTL Verilog code.
```bash
vcs -full64 Testbench/counter_tb.v -debug_access+all -lca -kdb
```
✔️ Compiles the testbench that drives the simulation.
```bash
./simv
```
✔️ Runs the compiled simulation.
```bash
verdi -ssf novas.fsdb -nologo
```
✔️ Opens the waveform file in Verdi for signal analysis.

### Synthesis (Using Design Compiler)
```bash
dc_shell
```
✔️ Starts the Design Compiler shell.
```bash
source run_dc.tcl
```
✔️ Runs the DC synthesis script.
```bash
start_gui
```
✔️ Launches the GUI version of Design Compiler.
```bash
report_qor
report_timing
report_power
```
✔️ Generates reports for quality of results, timing, and power usage.

### Constraints File Editing 
```bash
vi constraints/counter.sdc
```
✔️ Modifies timing constraints (e.g., clock period).

###  Physical Design (Using ICC2)
```bash
icc2_shell
start_gui
```
✔️ Launches the ICC2 shell and its GUI.

### Static Timing Analysis (Using PT)
```bash
pt_shell
start_gui
```
✔️ Launches the PrimeTime (PT) shell and its GUI.

## Post-Layout Analysis
```bash
report_timing
report_power
```
✔️ Reports updated timing and power metrics after routing.
```bash
write_gds -output results/counter.gds
```
✔️ Exports the final GDSII layout file.

##  Physical Design Steps (Using ICC2)
Each of the following steps is executed inside the icc2_shell or GUI:

1️⃣ Floorplanning
```bash
set PDK_PATH ./../ref

create_lib -ref_lib $PDK_PATH/lib/ndm/saed32rvt_c.ndm UP_DOWN_COUNTER_LIBDH
open_lib UP_DOWN_COUNTER

read_verilog {./../DC/results/up_down_counter.mapped.v} -library UP_DOWN_COUNTER_LIBDH -design up_down_counter -top up_down_counter

open_block up_down_counter

initialize_floorplan \
    -core_utilization 0.5 \
    -coincident_boundary false \
    -core_offset {1 2} \
    -shape U \
    -orientation W

create_placement_blockage \
    -type hard \
    -boundary {{4 4} {4 8} {8 8} {8 4}}

place_pins -self

create_placement -floorplan

save_block
save_lib
```
2️⃣ Powerplanning 
```bash
create_net -power {VDD}
create_net -ground {VSS}

connect_pg_net -all_blocks -automatic

create_pg_ring_pattern core_ring -horizontal_layer M7 -vertical_layer M8
set_pg_strategy power_ring -core -pattern {{name: core_ring} {nets: {VDD VSS}}}
compile_pg -strategies power_ring

create_pg_std_cell_conn_pattern rail -layers {M1}
set_pg_strategy stdcell_rail -core -pattern {{name: rail} {nets: {VDD VSS}}}
compile_pg -strategies stdcell_rail

save_block
```
3️⃣ Placement
```bash
remove_modes -all
remove_corners -all
remove_scenarios -all

create_mode func
create_corner nom
create_scenario -name func::nom -mode func -corner nom
current_mode func
current_scenario func::nom

source ./../constraints/counter.sdc

foreach cell {/FADD /HADD /AO /OA /XOR /NOR /XNOR /MUX} {
    set_dont_use [get_lib_cells *$cell*]
}

read_parasitic_tech -tlup $PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus \
                    -layermap $PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map -name p1

read_parasitic_tech -tlup $PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus \
                    -layermap $PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map -name p2

set_parasitic_parameters -late_spec p1 -early_spec p2

place_pins -self
place_opt
legalize_placement

save_block -as up_down_counter_project
save_lib
```
4️⃣ Clock Tree Synthesis (CTS)
```bash
check_design -checks pre_clock_tree_stage

synthesize_clock_tree

set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value false
set_app_options -name clock_opt.flow.enable_ccd -value true

clock_opt -to build_clock
clock_opt -from route_clock -to route_clock
clock_opt

save_block -as up_down_counter_cts_project
save_lib
```
5️⃣ Routing
```bash
set_app_options -name route.global.timing_driven -value true
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.track.crosstalk_driven -value true
set_app_options -name route.detail.timing_driven -value true
set_app_options -name route.detail.antenna -value true
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -name route.detail.diode_libcell_names -value */ANTENNA_RVT

route_global
route_track
route_detail
route_opt

write_verilog ./results/up_down_counter.routed.v
write_sdc -output ./results/up_down_counter.routed.sdc
write_parasitics -format spef -output ./results/up_down_counter_project_func::nom.spef
```

## Constraints Summary
| Constraint             | Value / Specification                                                               |
| ---------------------- | ----------------------------------------------------------------------------------- |
| **Clock Period**       | 1.75 ns                                                                             |
| **Clock Frequency**    | ~571.43 MHz                                                                        |
| **Cells Used**         | `AND`, `OR`, `NAND` |
| **Cells Avoided**      | `/FADD`, `/HADD`, `/AO`, `/OA`, `/XOR`, `/NOR`, `/XNOR`, `/MUX`                     |
| **Technology Library** | `SAED32nm` – RVT Cells                                                              |
| **Corner Used**        | TT (Typical-Typical)                                                                |


## Design Summary & Results
| Metric                  | Design Compiler (`dc_shell`) | ICC2 Post-Layout (`icc2_shell`) | PrimeTime (`pt_shell`)  |
| ----------------------- | ---------------------------- | ------------------------------- | ----------------------- |
| **Cell Area**           | 69.38 µm²                    | 75.33 µm²                       | 75.33 µm²               |
| **Slack (Setup)**       | +0.04 ns                     | +0.62 ns                        | +0.62 ns                |
| **Dynamic Power**       | 13.5589 µW                   | 48.84 µW                        | 50.10 µW *(assumed)*    |
| **Leakage Power**       | 126.33 nW                    | 147.0 pW                        | 158.0 pW *(assumed)*    |
| **Total Power**         | 13.6852 µW                   | 1.52e-01 µW                     | 1.60e-01 µW *(assumed)* |
| **Leaf Cell Count**     | 28                           | 28                              | 28                      |
| **Combinational Cells** | 24                           | 24                              | 24                      |
| **Sequential Cells**    | 4                            | 4                               | 4                       |

These are some snapshots for the reference:
<h4 align="center">

<p align="center">
  <img src="https://github.com/user-attachments/assets/1c29d51b-9051-45a0-8568-23244f9ab8d3" alt="Layout" width="350"/>
  <img src="https://github.com/user-attachments/assets/44f32f18-a439-4eb0-8d78-e69709f8f5e2" alt="Schematic" width="350"/>
</p>

<h4 align="center">

<p align="center">
  <img src="https://github.com/user-attachments/assets/b36c2e3c-ec16-4516-8c5e-a06bdc873a10" alt="Slack Report" width="350"/>
  <img src="https://github.com/user-attachments/assets/18ecbed7-e32c-445e-8a90-a738420e35a4" alt="Area Report" width="350"/>
</p>

<h4 align="center">

<p align="center">
  <img src="https://github.com/user-attachments/assets/a838b803-0336-4233-be03-db3ef959df6a" alt="Power Report" width="350"/>
</p>

## Final Layout and Schematic Diagram
<h4 align="center">🔲 Final ICC2 Layout</h4>
<p align="center">
  <img src="https://github.com/user-attachments/assets/bac1e51b-3152-4df1-8085-5ab2b94f6db5" alt="Final Layout" width="600"/>
</p>

<h4 align="center">📐 Schematic View</h4>
<p align="center">
  <img src="https://github.com/user-attachments/assets/ae5c6c54-8f99-45fc-a47c-57eb00182fb3" alt="Schematic View" width="600"/>
</p>

## Final Summary 
This project successfully demonstrates the complete RTL to GDSII flow for a 4-bit synchronous up/down counter using Verilog HDL and Synopsys tools. The design was verified through simulation, synthesized with timing constraints, and physically implemented using the SAED 32nm standard cell library under TT (Typical-Typical) corner.

✔️ Verified functionality through testbench-driven simulation (VCS + Verdi)

✔️ Synthesis performed with proper timing (slack between 0 to 1), area, and power constraints

✔️ Floorplanning, power planning, placement, CTS, and routing completed in ICC2

✔️ Final layout and GDSII generated with clean DRC and post-route analysis

The design is compact, timing-closed, and physically implementable.

## References 
- https://www.allaboutcircuits.com/
- https://www.vlsiexpert.com/
- https://www.chipgrad.com/
- [SAED 32nm PDK Documentation – Synopsys University Program]
- [Synopsys VCS, Design Compiler, ICC2, and PrimeTime User Guides]
- Lecture Notes and Tutorials provided by Mr. Puneet Mittal

## Credits 
This project was completed as part of the RTL to GDSII Flow Lab at Pandit Deendayal Energy University (PDEU).

We express our sincere gratitude to:

- Mr. Puneet Mittal, VLSI Expert, for his exceptional guidance, technical mentorship, and continued support throughout the project.

- The esteemed faculty members of the PDEU, for fostering a strong foundation in VLSI design and enabling practical learning through advanced EDA tools.

















    


    




