onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider  {Testbench}
add wave -noupdate -format Logic /tf/sys_clk
add wave -noupdate -format Logic /tf/data_trigger
add wave -noupdate -format Logic /tf/sensor_sim_reset_b

# EVB1006 ############################################################
add wave -noupdate -divider  {evb1006_dut_ext}
add wave -noupdate -format Logic /tf/dut/sys_clk
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/led

#add wave -noupdate -format Logic /tf/dut/pix_sdata
#add wave -noupdate -format Logic /tf/dut/pix_sclk
#add wave -noupdate -format Logic /tf/dut/pix_trigger
add wave -noupdate -format Logic /tf/dut/pix_reset

#add wave -noupdate -format Logic /tf/dut/pix_extclk
#add wave -noupdate -format Literal -radix hexadecimal /tf/dut/pix_strobe

#add wave -noupdate -format Logic /tf/dut/pix_clk
#add wave -noupdate -format Logic /tf/dut/pix_lv
#add wave -noupdate -format Logic /tf/dut/pix_fv
#add wave -noupdate -format Literal -radix hexadecimal /tf/dut/pix_data

add wave -noupdate -divider  {evb1006_dut_int}
add wave -noupdate -format Logic /tf/dut/reset_syspll
add wave -noupdate -format Logic /tf/dut/reset_pixpll
add wave -noupdate -format Logic /tf/dut/reset_async
add wave -noupdate -format Logic /tf/dut/reset_clkpix
add wave -noupdate -format Logic /tf/dut/reset_clkti
add wave -noupdate -format Logic /tf/dut/reset_phyclk

add wave -noupdate -divider  {Coordinator}
add wave -noupdate -format Logic /tf/dut/pingpong
add wave -noupdate -format Logic /tf/dut/imgctl_framedone
add wave -noupdate -format Logic /tf/dut/imgctl_skipped
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/skipped_count
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/buffer_done
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/buffer_full
add wave -noupdate -format Logic /tf/dut/buffer_active
add wave -noupdate -format Logic /tf/dut/ping_trig
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/ping_addr
add wave -noupdate -format Literal -radix unsigned /tf/dut/stateA

# Sensor Simulation ##################################################
add wave -noupdate -divider  {sensor_sim_ext}
add wave -noupdate -format Logic /tf/snsr_sm0/reset_b
add wave -noupdate -format Logic /tf/snsr_sm0/extclk
add wave -noupdate -format Logic /tf/snsr_sm0/frame_valid
add wave -noupdate -format Logic /tf/snsr_sm0/line_valid
add wave -noupdate -format Logic /tf/snsr_sm0/pixclk
add wave -noupdate -format Literal -radix hexadecimal /tf/snsr_sm0/dout

add wave -noupdate -divider  {sensor_sim_int}
add wave -noupdate -format Literal -radix unsigned //tf/snsr_sm0/i
add wave -noupdate -format Literal -radix unsigned //tf/snsr_sm0/j
add wave -noupdate -format Literal -radix unsigned //tf/snsr_sm0/row_count
add wave -noupdate -format Literal -radix unsigned //tf/snsr_sm0/col_count
add wave -noupdate -format Literal -radix unsigned //tf/snsr_sm0/lead_count
add wave -noupdate -format Literal -radix unsigned //tf/snsr_sm0/trail_count

# Image Interface ######################################################
add wave -noupdate -divider  {imgif0_ext}
add wave -noupdate -format Logic /tf/dut/imgif0/clk
add wave -noupdate -format Logic /tf/dut/imgif0/reset
add wave -noupdate -format Logic /tf/dut/imgif0/packing_mode

add wave -noupdate -format Logic /tf/dut/imgif0/pix_fv
add wave -noupdate -format Logic /tf/dut/imgif0/pix_lv
add wave -noupdate -format Logic /tf/dut/imgif0/pix_data

add wave -noupdate -format Logic /tf/dut/imgif0/trigger
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/start_addr
add wave -noupdate -format Logic /tf/dut/imgif0/frame_done
add wave -noupdate -format Logic /tf/dut/imgif0/skipped

add wave -noupdate -format Logic /tf/dut/imgif0/mem_clk
add wave -noupdate -format Logic /tf/dut/imgif0/mem_reset

add wave -noupdate -format Logic /tf/dut/imgif0/mem_wr_req
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/mem_wr_addr
add wave -noupdate -format Logic /tf/dut/imgif0/mem_wr_ack

add wave -noupdate -format Logic /tf/dut/imgif0/mem_wdata_rd_en
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/mem_wdata


add wave -noupdate -divider  {imgif0_int}
add wave -noupdate -format Logic /tf/dut/imgif0/reg_fv
add wave -noupdate -format Logic /tf/dut/imgif0/reg_lv
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/reg_pixdata

add wave -noupdate -format Logic /tf/dut/imgif0/reg_fv1
add wave -noupdate -format Logic /tf/dut/imgif0/reg_packing_mode
#add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/cmd_byte_addr_wr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/pixel_index

add wave -noupdate -format Logic /tf/dut/imgif0/fifo_wren
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/fifo_din
add wave -noupdate -format Logic /tf/dut/imgif0/fifo_reset
add wave -noupdate -format Logic /tf/dut/imgif0/fifo_empty
add wave -noupdate -format Logic /tf/dut/imgif0/fifo_full
add wave -noupdate -format Literal -radix unsigned /tf/dut/imgif0/fifo_rd_data_count
add wave -noupdate -format Literal -radix unsigned /tf/dut/imgif0/fifo_wr_data_count

add wave -noupdate -format Logic /tf/dut/imgif0/regm_fv
add wave -noupdate -format Logic /tf/dut/imgif0/regm_fv1
add wave -noupdate -format Logic /tf/dut/imgif0/trigger_hpc

add wave -noupdate -format Literal -radix hexadecimal /tf/dut/imgif0/cmd_start_address

add wave -noupdate -format Literal -radix unsigned /tf/dut/imgif0/state
add wave -noupdate -format Literal -radix unsigned /tf/dut/imgif0/pixbuf_state

# Memory Interface ######################################################
add wave -noupdate -divider  {memif_ext}
add wave -noupdate -format Logic /tf/dut/memif0/async_rst
add wave -noupdate -format Logic /tf/dut/memif0/sys_clk
add wave -noupdate -format Logic /tf/dut/memif0/phy_clk
add wave -noupdate -format Logic /tf/dut/memif0/reset_phy_clk_n
add wave -noupdate -format Logic /tf/dut/memif0/local_init_done
add wave -noupdate -format Logic /tf/dut/memif0/local_pll_locked

add wave -noupdate -format Logic /tf/dut/memif0/local_ready
add wave -noupdate -format Logic /tf/dut/memif0/local_burstbegin
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/local_address
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/local_size

add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/local_be
add wave -noupdate -format Logic /tf/dut/memif0/local_write_req
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/local_wdata

add wave -noupdate -format Logic /tf/dut/memif0/local_read_req
add wave -noupdate -format Logic /tf/dut/memif0/local_rdata_valid
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/local_rdata

add wave -noupdate -format Logic /tf/dut/memif0/mem_clk
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/mem_addr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/mem_ba
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/mem_dqs
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memif0/mem_dq

add wave -noupdate -format Logic /tf/dut/memif0/mem_cas_n
add wave -noupdate -format Logic /tf/dut/memif0/mem_cke
add wave -noupdate -format Logic /tf/dut/memif0/mem_clk_n
add wave -noupdate -format Logic /tf/dut/memif0/mem_cs_n
add wave -noupdate -format Logic /tf/dut/memif0/mem_dm
add wave -noupdate -format Logic /tf/dut/memif0/mem_odt
add wave -noupdate -format Logic /tf/dut/memif0/mem_ras_n
add wave -noupdate -format Logic /tf/dut/memif0/mem_we_n


# Memory Arbiter ######################################################
add wave -noupdate -divider  {memarb0_ext}
add wave -noupdate -format Logic /tf/dut/memarb0/clk
add wave -noupdate -format Logic /tf/dut/memarb0/reset
add wave -noupdate -format Logic /tf/dut/memarb0/calib_done

add wave -noupdate -format Logic /tf/dut/memarb0/hpc_ready
add wave -noupdate -format Logic /tf/dut/memarb0/hpc_burstbegin
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memarb0/hpc_size
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memarb0/hpc_address

add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memarb0/hpc_be
add wave -noupdate -format Logic /tf/dut/memarb0/hpc_write_req
add wave -noupdate -format Logic /tf/dut/memarb0/hpc_read_req

add wave -noupdate -format Logic /tf/dut/memarb0/rdata_valid
add wave -noupdate -format Logic /tf/dut/memarb0/wdata_rd_en

add wave -noupdate -format Logic /tf/dut/memarb0/wr_req
add wave -noupdate -format Logic /tf/dut/memarb0/wr_ack
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memarb0/wr_addr
add wave -noupdate -format Logic /tf/dut/memarb0/rd_req
add wave -noupdate -format Logic /tf/dut/memarb0/rd_ack
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memarb0/rd_addr

add wave -noupdate -divider  {memarb0_int}
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/memarb0/last_command
add wave -noupdate -format Literal -radix unsigned /tf/dut/memarb0/burst_cnt
add wave -noupdate -format Literal -radix unsigned /tf/dut/memarb0/state

# Host Interface ######################################################
add wave -noupdate -divider  {hstif0_ext}
add wave -noupdate -format Logic /tf/dut/hstif0/clk
add wave -noupdate -format Logic /tf/dut/hstif0/clk_ti
add wave -noupdate -format Logic /tf/dut/hstif0/reset_clk

add wave -noupdate -format Logic /tf/dut/hstif0/readout_start
add wave -noupdate -format Logic /tf/dut/hstif0/readout_done
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/readout_addr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/readout_count

add wave -noupdate -format Logic /tf/dut/hstif0/mem_rd_req
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/mem_rd_addr
add wave -noupdate -format Logic /tf/dut/hstif0/mem_rd_ack

add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/mem_rdata
add wave -noupdate -format Logic /tf/dut/hstif0/mem_rdata_valid

add wave -noupdate -format Logic /tf/dut/hstif0/ob_rd_en
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/pofifo0_rd_count
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/pofifo0_dout
#add wave -noupdate -format Logic /tf/dut/hstif0/pofifo0_full
#add wave -noupdate -format Logic /tf/dut/hstif0/pofifo0_empty

add wave -noupdate -divider  {hstif0_int}
add wave -noupdate -format Logic /tf/dut/hstif0/ob_wr_en
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/ob_din
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/ob_count
#add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/cmd_byte_addr_rd
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/hstif0/rd_byte_cnt
add wave -noupdate -format Logic /tf/dut/hstif0/fifo_reset

add wave -noupdate -format Literal -radix unsigned /tf/dut/hstif0/po_state

# Pipe Out ###########################################################
add wave -noupdate -divider  {po0_ext}
add wave -noupdate -format Logic /tf/dut/po0/ep_read
#add wave -noupdate -format Literal -radix hexadecimal /tf/dut/po0/ep_addr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/po0/ep_datain


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

