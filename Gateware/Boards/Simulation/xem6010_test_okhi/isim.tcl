onerror {resume}
divider add "Testbench"
wave add                 /tf/clk1
wave add                 /tf/dut/reset
wave add                 /tf/dut/c3_sys_rst_n
wave add                 /tf/dut/c3_rst0
wave add                 /tf/dut/c3_async_rst
wave add -radix unsigned /tf/dut/pipe_out_rd_count
wave add -radix unsigned /tf/fifo_rd_count

# Sensor Simulation ##################################################
#divider add "sensor_sim_ext"
#wave add                 /tf/snsr_sm0/reset_b
#wave add                 /tf/snsr_sm0/extclk
#wave add                 /tf/snsr_sm0/frame_valid
#wave add                 /tf/snsr_sm0/line_valid
#wave add                 /tf/snsr_sm0/pixclk
#wave add -radix hex      /tf/snsr_sm0/dout 

#divider add "sensor_sim_int"
#wave add -radix unsigned /tf/snsr_sm0/i
#wave add -radix unsigned /tf/snsr_sm0/j
#wave add -radix unsigned /tf/snsr_sm0/row_count
#wave add -radix unsigned /tf/snsr_sm0/col_count
#wave add -radix unsigned /tf/snsr_sm0/lead_count
#wave add -radix unsigned /tf/snsr_sm0/trail_count

# EVB1005 ############################################################
divider add "evb1005_dut_ext"
wave add -radix hex      /tf/dut/hi_in
wave add -radix hex      /tf/dut/hi_out
wave add -radix hex      /tf/dut/hi_inout
#wave add                /tf/dut/okAA
#wave add -radix hex      /tf/dut/led
	
wave add                 /tf/dut/sdata
wave add                 /tf/dut/sclk
#wave add                 /tf/dut/trigger
wave add                 /tf/dut/reset_b

wave add                 /tf/dut/extclk
#wave add -radix hex      /tf/dut/strobe
	
wave add                 /tf/dut/pix_clk
wave add                 /tf/dut/line_valid
wave add                 /tf/dut/frame_valid
wave add -radix hex      /tf/dut/pix_data

divider add "evb1005_dut_int"
wave add                 /tf/dut/c3_pll_lock
wave add                 /tf/dut/extclk_locked
wave add                 /tf/dut/pixclk_dcm_locked

divider add "Resets"
wave add                 /tf/dut/c3_sys_rst_n
wave add                 /tf/dut/extclk_rst
wave add                 /tf/dut/reset_b
wave add                 /tf/dut/pixclk_dcm_reset
wave add                 /tf/dut/reset

divider add "i2c_ctrl0_ext"
wave add                 /tf/dut/i2c_ctrl0/clk
wave add                 /tf/dut/i2c_ctrl0/reset
wave add                 /tf/dut/i2c_ctrl0/start
wave add                 /tf/dut/i2c_ctrl0/done

wave add                 /tf/dut/i2c_ctrl0/memclk
wave add                 /tf/dut/i2c_ctrl0/memstart
wave add                 /tf/dut/i2c_ctrl0/memwrite
wave add                 /tf/dut/i2c_ctrl0/memread

wave add -radix hex      /tf/dut/i2c_ctrl0/memdin
wave add -radix hex      /tf/dut/i2c_ctrl0/memdout

wave add      /tf/dut/i2c_ctrl0/i2c_sclk
wave add      /tf/dut/i2c_ctrl0/i2c_sdat

divider add "i2c_ctrl0_int"
wave add -radix unsigned      /tf/dut/i2c_ctrl0/state
wave add -radix unsigned      /tf/dut/i2c_ctrl0/mem_addr
wave add -radix unsigned      /tf/dut/i2c_ctrl0/cmem_addr
wave add -radix hex           /tf/dut/i2c_ctrl0/cmem_dout

wave add                      /tf/dut/i2c_ctrl0/rmem_write
wave add -radix unsigned      /tf/dut/i2c_ctrl0/rmem_addr
wave add -radix hex           /tf/dut/i2c_ctrl0/rmem_din


wave add -radix unsigned /tf/dut/i2c_ctrl0/divcount
wave add                 /tf/dut/i2c_ctrl0/divenable
wave add -radix hex      /tf/dut/i2c_ctrl0/phase

wave add                 /tf/dut/i2c_ctrl0/tx_start
wave add -radix unsigned /tf/dut/i2c_ctrl0/tx_count
wave add                 /tf/dut/i2c_ctrl0/tx_enable
wave add -radix hex      /tf/dut/i2c_ctrl0/tx_word
wave add -radix hex      /tf/dut/i2c_ctrl0/tx_shift
wave add -radix hex      /tf/dut/i2c_ctrl0/tx_tok
wave add -radix unsigned /tf/dut/i2c_ctrl0/tcount
wave add                 /tf/dut/i2c_ctrl0/twrite


# Image Interface ######################################################   
divider add "img_if0_ext"
wave add                 /tf/dut/imgif0/clk
wave add                 /tf/dut/imgif0/pixclk
wave add                 /tf/dut/imgif0/reset
wave add                 /tf/dut/imgif0/calib_done
wave add                 /tf/dut/imgif0/frame_valid
wave add                 /tf/dut/imgif0/line_valid
wave add -radix hex      /tf/dut/imgif0/pix_data  

wave add                 /tf/dut/imgif0/frame_valid_p0
wave add                 /tf/dut/imgif0/line_valid_p0
wave add -radix unsigned /tf/dut/imgif0/pix_data_p0  

wave add                 /tf/dut/imgif0/store_frame
wave add                 /tf/dut/imgif0/frame_ready

                   

wave add                 /tf/dut/imgif0/p0_wr_en
wave add -radix hex      /tf/dut/imgif0/p0_wr_data
wave add -radix hex      /tf/dut/imgif0/p0_wr_mask
wave add                 /tf/dut/imgif0/p0_cmd_en
wave add -radix hex      /tf/dut/imgif0/p0_cmd_instr
wave add -radix unsigned      /tf/dut/imgif0/p0_cmd_byte_addr
wave add -radix unsigned      /tf/dut/imgif0/p0_cmd_bl_o

wave add                 /tf/dut/c3_p0_cmd_full
wave add                 /tf/dut/c3_p0_cmd_empty
wave add                 /tf/dut/c3_p0_wr_full
wave add -radix unsigned /tf/dut/c3_p0_wr_count
wave add                 /tf/dut/c3_p0_wr_empty
wave add                 /tf/dut/c3_p0_wr_underrun
wave add                 /tf/dut/c3_p0_wr_error

divider add "img_if0_int"

wave add -radix unsigned /tf/dut/imgif0/store_frame_reg
wave add                 /tf/dut/imgif0/frame_sync
wave add -radix hex      /tf/dut/imgif0/frame_toggle_d
wave add -radix unsigned /tf/dut/imgif0/row_count
wave add -radix unsigned /tf/dut/imgif0/col_count
#wave add -radix unsigned /tf/dut/imgif0/debug_count

wave add -radix unsigned /tf/dut/imgif0/cmd_byte_addr_wr 
wave add -radix unsigned /tf/dut/imgif0/write_cnt
wave add -radix unsigned /tf/dut/imgif0/pixel_index

# Host Interface ######################################################   
divider add "hstif0_ext"

wave add -radix hex      /tf/dut/hstif0/p1_rd_en
wave add -radix hex      /tf/dut/hstif0/p1_rd_data
wave add                 /tf/dut/hstif0/p1_rd_empty
	
wave add                 /tf/dut/hstif0/p1_cmd_en
wave add -radix hex      /tf/dut/hstif0/p1_cmd_instr
wave add -radix hex      /tf/dut/hstif0/p1_cmd_byte_addr
wave add -radix unsigned      /tf/dut/hstif0/p1_cmd_bl_o

wave add                 /tf/dut/c3_p1_cmd_full
wave add                 /tf/dut/c3_p1_cmd_empty
wave add -radix unsigned /tf/dut/c3_p1_rd_count
wave add                 /tf/dut/c3_p1_rd_full
wave add                 /tf/dut/c3_p1_rd_overflow
wave add                 /tf/dut/c3_p1_rd_error

divider add "hstif0_int"
wave add   -radix unsigned              /tf/dut/hstif0/po_state

divider add "DDR Output Buffer"
wave add                 /tf/dut/hstif0/ob_wr_en 
wave add -radix hex      /tf/dut/hstif0/ob_din
wave add -radix unsigned /tf/dut/hstif0/ob_count
wave add -radix unsigned /tf/dut/hstif0/cmd_byte_addr_rd
wave add -radix unsigned /tf/dut/hstif0/rd_burst_cnt
wave add   -radix unsigned              /tf/dut/hstif0/rd_pixel_cnt

divider add "Memory Interface"
wave add                 /tf/mcb3_dram_ck;  
#wave add                 /tf/mcb3_dram_ck_n
wave add -radix hex      /tf/mcb3_dram_a
wave add -radix hex      /tf/mcb3_dram_ba  
wave add -radix hex      /tf/mcb3_dram_dq   
#wave add                 /tf/mcb3_dram_dqs  
#wave add                 /tf/mcb3_dram_dqs_n
#wave add                 /tf/mcb3_dram_dm
#wave add                 /tf/mcb3_dram_ras_n
#wave add                 /tf/mcb3_dram_cas_n 
wave add                 /tf/mcb3_dram_we_n  
wave add                 /tf/mcb3_dram_cke 
#wave add                 /tf/mcb3_dram_odt   
#wave add                 /tf/mcb3_dram_udqs   
#wave add                 /tf/mcb3_dram_udqs_n  
#wave add                 /tf/mcb3_dram_udm


run 50 us
quit