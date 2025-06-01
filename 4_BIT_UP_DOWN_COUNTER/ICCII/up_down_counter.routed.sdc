################################################################################
#
# Design name:  up_down_counter
#
# Created by icc2 write_sdc on Sun Jun  1 05:24:48 2025
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: func
# Corner: nom
# Scenario: func::nom

# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 1
create_clock -name clk -period 1.75 -waveform {0 0.875} [get_ports {clk}]
# Warning: Libcell power domain derates are skipped!

set_clock_uncertainty -setup 0.3 [get_clocks {clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {clk}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 4
set_input_transition 0.5 [get_ports {clk}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 4
set_input_transition 0.5 [get_ports {reset}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 4
set_input_transition 0.5 [get_ports {up_down}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 3
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {clk}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 3
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {reset}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 3
set_input_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {up_down}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 6
set_output_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {count[3]}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 6
set_output_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {count[2]}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 6
set_output_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {count[1]}]
# /home/student/Downloads/RTL2GDSII/CONSTRAINTS/counter.sdc, line 6
set_output_delay -clock [get_clocks {clk}] -max 0.5 [get_ports {count[0]}]
set_max_transition 0.25 [current_design]
set_max_transition 0.15 [get_clocks {clk}] -clock_path
