#------------------------------------------------------------------------
# sim_loopback_ver.do
#
# Modelsim simulation script for loopback testing of frontpanel simulations
# for distribution. 
#
#------------------------------------------------------------------------
# Copyright (c) 2005-2010 Opal Kelly Incorporated
# $Id$
#------------------------------------------------------------------------

# Paths
set OKSIM ./oksim
set HPC   ../HPC

# Aliases
alias c   "do test.do"

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

# HPC II
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_alt_mem_ddrx_controller_top.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_controller.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_addr_cmd.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_addr_cmd_wrap.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_controller_st_top.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ddr2_odt_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ddr3_odt_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_lpddr2_addr_cmd.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_odt_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_rdwr_data_tmg.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_arbiter.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_burst_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_cmd_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_csr.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_buffer.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_buffer_manager.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_burst_tracking.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_dataid_manager.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_fifo.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_list.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_rdata_path.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_wdata_path.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_decoder.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_decoder_32_syn.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_decoder_64_syn.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder_32_syn.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder_64_syn.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_input_if.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_mm_st_converter.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_rank_timer.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_sideband.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_tbp.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_timing_param.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_phy_alt_mem_phy_seq_wrapper.vo
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_phy.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_controller.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ddr2_odt_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ddr3_odt_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_rdwr_data_tmg.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_arbiter.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_buffer.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_burst_tracking.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_dataid_manager.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_fifo.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_list.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_wdata_path.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_decoder.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_decoder_32_syn.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder_32_syn.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_input_if.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_mm_st_converter.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_rank_timer.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_phy_alt_mem_phy_pll.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_phy_defines.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_example_top.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_controller_phy.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_example_driver.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_ex_lfsr8.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_alt_mem_ddrx_controller_top.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_addr_cmd.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_addr_cmd_wrap.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_controller_st_top.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_odt_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_burst_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_cmd_gen.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_rdata_path.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_sideband.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_tbp.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/alt_mem_ddrx_timing_param.v
vlog -vlog01compat -work work +incdir+$HPC $HPC/ddr2_interface_phy_alt_mem_phy.v

#DRAM Model
vlog -vlog01compat -work work +incdir+$HPC/testbench $HPC/testbench/ddr2_interface_example_top_tb.v
vlog -vlog01compat -work work +incdir+$HPC/testbench $HPC/testbench/ddr2_interface_mem_model.v

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  ddr2_interface_example_top_tb

# Waves
do test_example_wave.do

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/ddr2_interface_inst/local_init_done

#add wave *
view structure
view signals
run -all

run 10us

#WaveRestoreZoom 0 50us
