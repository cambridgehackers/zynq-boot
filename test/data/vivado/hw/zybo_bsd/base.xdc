set_property PACKAGE_PIN R18 [get_ports {btns_4bits_tri_i[0]}]
set_property PACKAGE_PIN P16 [get_ports {btns_4bits_tri_i[1]}]
set_property PACKAGE_PIN V16 [get_ports {btns_4bits_tri_i[2]}]
set_property PACKAGE_PIN Y16 [get_ports {btns_4bits_tri_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btns_4bits_tri_i[*]}]

set_property PACKAGE_PIN M14 [get_ports {leds_4bits_tri_o[0]}]
set_property PACKAGE_PIN M15 [get_ports {leds_4bits_tri_o[1]}]
set_property PACKAGE_PIN G14 [get_ports {leds_4bits_tri_o[2]}]
set_property PACKAGE_PIN D18 [get_ports {leds_4bits_tri_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_4bits_tri_o[*]}]

set_property PACKAGE_PIN G15 [get_ports {sws_4bits_tri_i[0]}]
set_property PACKAGE_PIN P15 [get_ports {sws_4bits_tri_i[1]}]
set_property PACKAGE_PIN W13 [get_ports {sws_4bits_tri_i[2]}]
set_property PACKAGE_PIN T16 [get_ports {sws_4bits_tri_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sws_4bits_tri_i[*]}]

set_property PACKAGE_PIN N18 [get_ports iic_0_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_scl_io]
set_property PACKAGE_PIN N17 [get_ports iic_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_sda_io]

set_property PACKAGE_PIN M19 [get_ports {RED_O[0]}]
set_property PACKAGE_PIN L20 [get_ports {RED_O[1]}]
set_property PACKAGE_PIN J20 [get_ports {RED_O[2]}]
set_property PACKAGE_PIN G20 [get_ports {RED_O[3]}]
set_property PACKAGE_PIN F19 [get_ports {RED_O[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RED_O[*]}]
set_property SLEW FAST [get_ports {RED_O[*]}]

set_property PACKAGE_PIN H18 [get_ports {GREEN_O[0]}]
set_property PACKAGE_PIN N20 [get_ports {GREEN_O[1]}]
set_property PACKAGE_PIN L19 [get_ports {GREEN_O[2]}]
set_property PACKAGE_PIN J19 [get_ports {GREEN_O[3]}]
set_property PACKAGE_PIN H20 [get_ports {GREEN_O[4]}]
set_property PACKAGE_PIN F20 [get_ports {GREEN_O[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GREEN_O[*]}]
set_property SLEW FAST [get_ports {GREEN_O[*]}]

set_property PACKAGE_PIN P20 [get_ports {BLUE_O[0]}]
set_property PACKAGE_PIN M20 [get_ports {BLUE_O[1]}]
set_property PACKAGE_PIN K19 [get_ports {BLUE_O[2]}]
set_property PACKAGE_PIN J18 [get_ports {BLUE_O[3]}]
set_property PACKAGE_PIN G19 [get_ports {BLUE_O[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BLUE_O[*]}]
set_property SLEW FAST [get_ports {BLUE_O[*]}]

set_property PACKAGE_PIN R19 [get_ports VSYNC_O]
set_property PACKAGE_PIN P19 [get_ports HSYNC_O]
set_property IOSTANDARD LVCMOS33 [get_ports VSYNC_O]
set_property IOSTANDARD LVCMOS33 [get_ports HSYNC_O]
set_property SLEW FAST [get_ports VSYNC_O]
set_property SLEW FAST [get_ports HSYNC_O]

set_property PACKAGE_PIN H16 [get_ports HDMI_CLK_P]
set_property PACKAGE_PIN D19 [get_ports HDMI_D0_P]
set_property PACKAGE_PIN C20 [get_ports HDMI_D1_P]
set_property PACKAGE_PIN B19 [get_ports HDMI_D2_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_CLK_*]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D*]

set_property PACKAGE_PIN F17 [get_ports {HDMI_OEN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {HDMI_OEN[0]}]

set_property PACKAGE_PIN K18 [get_ports {AC_BCLK[0]}]
set_property PACKAGE_PIN T19 [get_ports AC_MCLK]
set_property PACKAGE_PIN P18 [get_ports {AC_MUTE_N[0]}]
set_property PACKAGE_PIN L17 [get_ports {AC_PBLRC[0]}]
set_property PACKAGE_PIN M18 [get_ports {AC_RECLRC[0]}]
set_property PACKAGE_PIN M17 [get_ports {AC_SDATA_O[0]}]
set_property PACKAGE_PIN K17 [get_ports AC_SDATA_I]
set_property IOSTANDARD LVCMOS33 [get_ports AC*]

#This constraint ensures the MMCM located in the clock region connected to the ZYBO's HDMI port
#is used for the axi_dispctrl core driving the HDMI port
set_property LOC MMCME2_ADV_X0Y0 [get_cells system_i/axi_dispctrl_0/inst/DONT_USE_BUFR_DIV5.Inst_mmcme2_drp/mmcm_adv_inst]

#False path constraints for crossing clock domains in the Audio and Display cores.
#Synchronization between the clock domains is handled properly in logic.
#TODO: The following constraints should be changed to identify the proper pins
#      of the cores by their hierarchical pin names. Currently the global clock names are
#      used. Ultimately, it would be nice to have the cores automatically generate them.
#adi_i2s constaints:
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks clk_fpga_2]
set_false_path -from [get_clocks clk_fpga_2] -to [get_clocks clk_fpga_0]

#axi_dispctrl constraints:
#Note these constraints require that REFCLK be driven by the axi_lite clock (clk_fpga_0)
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks axi_dispctrl_1_PXL_CLK_O]
set_false_path -from [get_clocks axi_dispctrl_1_PXL_CLK_O] -to [get_clocks clk_fpga_0]

create_generated_clock -name vga_pxlclk -source [get_pins {system_i/processing_system7_0/inst/PS7_i/FCLKCLK[0]}] -multiply_by 1 [get_pins system_i/axi_dispctrl_0/inst/DONT_USE_BUFR_DIV5.BUFG_inst/O]
set_false_path -from [get_clocks vga_pxlclk] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks vga_pxlclk]
