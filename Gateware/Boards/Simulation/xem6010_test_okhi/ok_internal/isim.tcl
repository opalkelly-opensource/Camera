onerror {resume}
divider add "Testbench"
wave add                 /tf/c3_sys_clk
wave add                 /tf/c3_sys_rst;

wave add                 /tf/rst_xfer
wave add                 /tf/wr_data
wave add                 /tf/wr_en
wave add                 /tf/rd_en
wave add                 /tf/xfer_mode
wave add                 /tf/write_mode
wave add                 /tf/read_mode

divider add "Memory Interface"
wave add                 /tf/mcb3_dram_ck;  
#wave add                 /tf/mcb3_dram_ck_n
wave add -radix hex      /tf/mcb3_dram_a
wave add -radix hex      /tf/mcb3_dram_ba  
wave add -radix hex      /tf/mcb3_dram_dq   
wave add                 /tf/mcb3_dram_dqs  
#wave add                 /tf/mcb3_dram_dqs_n
wave add                 /tf/mcb3_dram_dm
wave add                 /tf/mcb3_dram_ras_n
wave add                 /tf/mcb3_dram_cas_n 
wave add                 /tf/mcb3_dram_we_n  
wave add                 /tf/mcb3_dram_cke 
#wave add                 /tf/mcb3_dram_odt   
#wave add                 /tf/mcb3_dram_udqs   
#wave add                 /tf/mcb3_dram_udqs_n  
#wave add                 /tf/mcb3_dram_udm

divider add "ddr2_test_int"
wave add -radix hex      /tf/dut/state

divider add "ddr2_test_ext"
wave add                 /tf/dut/clk
wave add                 /tf/dut/reset
wave add                 /tf/dut/reads_en
wave add                 /tf/dut/writes_en
wave add                 /tf/dut/calib_done
	
wave add                 /tf/dut/wr_clk
wave add                 /tf/dut/wr_en
wave add -radix hex      /tf/dut/wr_data
	
wave add                 /tf/dut/rd_clk
wave add                 /tf/dut/rd_en
wave add -radix hex      /tf/dut/rd_data
wave add                 /tf/dut/rd_fifo_valid
	
wave add                 /tf/dut/p0_rd_en_o
wave add                 /tf/dut/p0_rd_empty
wave add -radix hex      /tf/dut/p0_rd_data
	
wave add                 /tf/dut/p0_cmd_en
wave add                 /tf/dut/p0_cmd_full
wave add -radix hex      /tf/dut/p0_cmd_instr
wave add -radix hex      /tf/dut/p0_cmd_byte_addr
wave add -radix hex      /tf/dut/p0_cmd_bl_o
	
wave add                 /tf/dut/p0_wr_en
wave add                 /tf/dut/p0_wr_full
wave add -radix hex      /tf/dut/p0_wr_data
wave add -radix hex      /tf/dut/p0_wr_mask
#wave add -radix hex      /tf/dut/debug
   
#wave add /tf
run 40 us
quit