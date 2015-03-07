
create_project -in_memory -part xc7z010clg400-1
set_property target_language Verilog [current_project]
set_param project.compositeFile.enableAutoGeneration 0

read_ip ../system_processing_system7_0_0/system_processing_system7_0_0.xci
generate_target all [get_ips system_processing_system7_0_0]
synth_ip [get_ips system_processing_system7_0_0]

read_verilog ../system_wrapper.v
read_xdc ../base.xdc

set_param synth.vivado.isSynthRun true
synth_design -top system_wrapper -part xc7z010clg400-1
write_checkpoint system_wrapper.dcp

add_files -quiet system_wrapper.dcp
read_xdc -ref system_processing_system7_0_0 -cells inst ../system_processing_system7_0_0/system_processing_system7_0_0.xdc
read_xdc ../base.xdc
link_design -top system_wrapper -part xc7z010clg400-1
opt_design 
place_design 
write_checkpoint -force system_wrapper_placed.dcp
report_io -file system_wrapper_io_placed.rpt
report_clock_utilization -file system_wrapper_clock_utilization_placed.rpt
report_utilization -file system_wrapper_utilization_placed.rpt -pb system_wrapper_utilization_placed.pb
report_control_sets -verbose -file system_wrapper_control_sets_placed.rpt

route_design 
write_checkpoint -force system_wrapper_routed.dcp
report_drc -file system_wrapper_drc_routed.rpt -pb system_wrapper_drc_routed.pb
report_timing_summary -warn_on_violation -file system_wrapper_timing_summary_routed.rpt -pb system_wrapper_timing_summary_routed.pb
report_power -file system_wrapper_power_routed.rpt -pb system_wrapper_power_summary_routed.pb
write_bitstream -bin_file -force ../zybobsd.bit
