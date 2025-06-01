set PDK_PATH ./../ref

create_lib -ref_lib $PDK_PATH/lib/ndm/saed32rvt_c.ndm FULL_ADDER_LIBDH

read_verilog {./../DC/results/full_adder.mapped.v} -library FULL_ADDER_LIBDH -design full_adder -top full_adder

#open the lib and block after saving
open_lib FULL_ADDER_LIBDH
open_block FULL_ADD


# FloorPlan settings
#scenario10:
initialize_floorplan -core_utilization 0.5 -coincident_boundary false -core_offset {1 2} -shape U -orientation W
create_placement_blockage -type hard -boundary {{4 4} {4 8} {8 8} {8 4}}
place_pins -self
create_placement -floorplan

save_block
save_lib


#open_lib <lib name>
##open_block <block name>
#


