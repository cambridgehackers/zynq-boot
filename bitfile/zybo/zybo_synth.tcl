
create_project zybo . -part xc7z010clg400-1
set_property target_language Verilog [current_project]
#set_param project.compositeFile.enableAutoGeneration 0

create_ip -name processing_system7 -vendor xilinx.com -library ip -module_name ps7_0
set_property -dict [list CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V}] [get_ips ps7_0]
set_property -dict [list CONFIG.PCW_USE_M_AXI_GP1 {1} CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_S_AXI_HP1 {1} CONFIG.PCW_USE_S_AXI_HP2 {1} CONFIG.PCW_USE_S_AXI_HP3 {1}] [get_ips ps7_0]
set_property -dict [list CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} CONFIG.PCW_UART0_UART0_IO {MIO 50 .. 51} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1}] [get_ips ps7_0]
set_property -dict [list CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J128M16 HA-125}] [get_ips ps7_0]
# report_property [get_ips ps7_0]
##set_property -dict [list CONFIG.preset {Default}] [get_ips ps7_0]
generate_target {instantiation_template} [get_files zybo.srcs/sources_1/ip/ps7_0/ps7_0.xci]
generate_target all [get_files zybo.srcs/sources_1/ip/ps7_0/ps7_0.xci]

generate_target {Synthesis} [get_files zybo.srcs/sources_1/ip/ps7_0/ps7_0.xci]
synth_ip [get_ips ps7_0]

read_verilog ../system_wrapper.v

set_param synth.vivado.isSynthRun true
synth_design -top system_wrapper -part xc7z010clg400-1
write_checkpoint system_wrapper.dcp

add_files -quiet system_wrapper.dcp
read_xdc -ref ps7_0 -cells inst zybo.srcs/sources_1/ip/ps7_0/ps7_0.xdc
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
