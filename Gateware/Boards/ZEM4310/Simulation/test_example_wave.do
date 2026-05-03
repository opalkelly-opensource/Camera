onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider  {Testbench}


# Memory Interface ######################################################
add wave -noupdate -divider  {memif_ext}
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/clock_source
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/global_reset_n

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/phy_clk
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/reset_phy_clk_n

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/ddr2_interface_inst/local_init_done

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_aux_full_rate_clk
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_aux_half_rate_clk

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_local_ready
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/local_burstbegin_sig
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_local_addr
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_local_size

add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_local_be
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_local_write_req
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_local_wdata

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_local_read_req
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_local_rdata_valid
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_local_rdata

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_clk
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_addr
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_ba
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_dqs
add wave -noupdate -format Literal -radix hexadecimal /ddr2_interface_example_top_tb/dut/mem_dq

add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_cas_n
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_cke
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_clk_n
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_cs_n
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_dm
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_odt
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_ras_n
add wave -noupdate -format Logic /ddr2_interface_example_top_tb/dut/mem_we_n



TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {159624642 ps} 0}
configure wave -namecolwidth 331
configure wave -valuecolwidth 48
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update