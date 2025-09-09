onerror {resume}
divider add "Testbench"
wave add                 /tf/c3_sys_clk
wave add                 /tf/c3_sys_rst;
wave add                 /tf/c3_sys_rst_n;
wave add                 /tf/data_trigger

#divider add "Memory Interface"
#wave add                 /tf/mcb3_dram_ck;  
#wave add                 /tf/mcb3_dram_ck_n
#wave add -radix hex      /tf/mcb3_dram_a
#wave add -radix hex      /tf/mcb3_dram_ba  
#wave add -radix hex      /tf/mcb3_dram_dq   
#wave add                 /tf/mcb3_dram_dqs  
#wave add                 /tf/mcb3_dram_dqs_n
#wave add                 /tf/mcb3_dram_dm
#wave add                 /tf/mcb3_dram_ras_n
#wave add                 /tf/mcb3_dram_cas_n 
#wave add                 /tf/mcb3_dram_we_n  
#wave add                 /tf/mcb3_dram_cke 
#wave add                 /tf/mcb3_dram_odt   
#wave add                 /tf/mcb3_dram_udqs   
#wave add                 /tf/mcb3_dram_udqs_n  
#wave add                 /tf/mcb3_dram_udm



# Sensor Simulation ##################################################
divider add "sensor_sim_ext"
wave add                 /tf/snsr_sm0/reset_b
wave add                 /tf/snsr_sm0/extclk
wave add                 /tf/snsr_sm0/frame_valid
wave add                 /tf/snsr_sm0/line_valid
wave add                 /tf/snsr_sm0/pixclk
wave add -radix hex      /tf/snsr_sm0/dout 

divider add "sensor_sim_int"
wave add -radix unsigned /tf/snsr_sm0/i
wave add -radix unsigned /tf/snsr_sm0/j
wave add -radix unsigned /tf/snsr_sm0/row_count
wave add -radix unsigned /tf/snsr_sm0/col_count
wave add -radix unsigned /tf/snsr_sm0/lead_count
wave add -radix unsigned /tf/snsr_sm0/trail_count

# EVB1005 ############################################################
divider add "evb1005_dut_int"
wave add -radix hex      /tf/dut/data_ready


divider add "evb1005_dut_ext"
wave add -radix hex      /tf/dut/okGH
wave add -radix hex      /tf/dut/okHG
#wave add                 /tf/dut/okAA
wave add -radix hex      /tf/dut/led
	
wave add                 /tf/dut/sdata
wave add                 /tf/dut/sclk
wave add                 /tf/dut/trigger
wave add                 /tf/dut/reset

wave add                 /tf/dut/extclk
wave add -radix hex      /tf/dut/strobe
	
wave add                 /tf/dut/pix_clk
wave add                 /tf/dut/line_valid
wave add                 /tf/dut/frame_valid
wave add -radix hex      /tf/dut/pix_data

#wave add                 /tf/dut/calib_done
#wave add                 /tf/dut/error

# Pixel Grabber ######################################################   
divider add "plx_grbbr0_ext"
wave add                 /tf/dut/plx_grbbr0/pixclk
wave add                 /tf/dut/plx_grbbr0/reset
wave add                 /tf/dut/plx_grbbr0/frame_valid
wave add                 /tf/dut/plx_grbbr0/line_valid
wave add -radix hex      /tf/dut/plx_grbbr0/pix_data
wave add                 /tf/dut/plx_grbbr0/write_enable
wave add -radix hex      /tf/dut/plx_grbbr0/packed_pixel_data(
wave add                 /tf/dut/plx_grbbr0/frame_done

divider add "plx_grbbr0_int"
wave add -radix unsigned /tf/dut/plx_grbbr0/row_count
wave add -radix unsigned /tf/dut/plx_grbbr0/col_count
wave add                 /tf/dut/plx_grbbr0/frame_toggle
wave add -radix hex      /tf/dut/plx_grbbr0/frame_toggle_d
wave add -radix hex      /tf/dut/plx_grbbr0/pixel_index
wave add -radix unsigned /tf/dut/plx_grbbr0/debug_count

# Pipe Out ###########################################################  
divider add "po0_ext"
wave add                /tf/dut/po0/ep_clk
wave add                /tf/dut/po0/ep_start
wave add                /tf/dut/po0/ep_done
wave add                /tf/dut/po0/ep_fifo_reset
wave add                /tf/dut/po0/ep_write
wave add -radix hex     /tf/dut/po0/ep_data
wave add -radix hex     /tf/dut/po0/ep_count
wave add                /tf/dut/po0/ep_full

#wave add /tf
run 40 us
quit