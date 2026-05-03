
add_wave_divider "Testbench"
add_wave                 /tf/sys_clk
add_wave                 /tf/data_wire
add_wave                 /tf/sensor_sim_reset_b


# EVB1006 ############################################################
add_wave_divider "evb1006_dut_ext"
add_wave                 /tf/sys_clkp
add_wave -radix hex      /tf/dut/led

#add_wave                 /tf/dut/pix_sdata
#add_wave                 /tf/dut/pix_sclk
#add_wave                 /tf/dut/pix_trigger
add_wave                 /tf/dut/pix_reset

#add_wave                 /tf/dut/pix_extclk
#add_wave -radix hex      /tf/dut/pix_strobe

#add_wave                 /tf/dut/pix_clk
#add_wave                 /tf/dut/pix_lv
#add_wave                 /tf/dut/pix_fv
#add_wave -radix hex      /tf/dut/pix_data

add_wave_divider "evb1006_dut_int"
add_wave                 /tf/dut/reset_syspll
add_wave                 /tf/dut/reset_pixdcm
add_wave                 /tf/dut/reset_async
add_wave                 /tf/dut/reset_clkpix
add_wave                 /tf/dut/reset_clkti
add_wave                 /tf/dut/reset_memif_clk

add_wave                 /tf/dut/imgctl_skipped
add_wave -radix hex      /tf/dut/skipped_count

# Sensor Simulation ##################################################
add_wave_divider "sensor_sim_ext"
add_wave                 /tf/snsr_sm0/reset_b
add_wave                 /tf/snsr_sm0/extclk
add_wave                 /tf/snsr_sm0/frame_valid
add_wave                 /tf/snsr_sm0/line_valid
add_wave                 /tf/snsr_sm0/pixclk
add_wave -radix hex      /tf/snsr_sm0/dout

add_wave_divider "sensor_sim_int"
add_wave -radix unsigned /tf/snsr_sm0/i
add_wave -radix unsigned /tf/snsr_sm0/j
add_wave -radix unsigned /tf/snsr_sm0/row_count
add_wave -radix unsigned /tf/snsr_sm0/col_count
add_wave -radix unsigned /tf/snsr_sm0/lead_count
add_wave -radix unsigned /tf/snsr_sm0/trail_count

# Image Interface ######################################################
add_wave_divider "imgif0_ext"
add_wave                 /tf/dut/imgif0/clk
add_wave                 /tf/dut/imgif0/reset
add_wave                 /tf/dut/imgif0/packing_mode

add_wave                 /tf/dut/imgif0/pix_fv
add_wave                 /tf/dut/imgif0/pix_lv
add_wave -radix hex      /tf/dut/imgif0/pix_data

add_wave                 /tf/dut/imgif0/trigger
add_wave -radix hex      /tf/dut/imgif0/start_addr
add_wave                 /tf/dut/imgif0/frame_done
add_wave                 /tf/dut/imgif0/frame_written
add_wave                 /tf/dut/imgif0/skipped

add_wave                 /tf/dut/imgif0/mem_clk
add_wave                 /tf/dut/imgif0/mem_reset

add_wave                 /tf/dut/imgif0/mem_wr_req
add_wave -radix hex      /tf/dut/imgif0/mem_wr_addr
add_wave                 /tf/dut/imgif0/mem_wr_ack

add_wave -radix hex      /tf/dut/imgif0/fifo_rd_data_count
add_wave                 /tf/dut/imgif0/mem_wdata_rd_en
add_wave -radix hex      /tf/dut/imgif0/mem_wdf_data
add_wave                 /tf/dut/imgif0/fifo_full
add_wave                 /tf/dut/imgif0/fifo_empty


add_wave_divider "imgif0_int"
add_wave                 /tf/dut/imgif0/reg_fv
add_wave                 /tf/dut/imgif0/reg_lv
add_wave -radix hex      /tf/dut/imgif0/reg_pixdata

add_wave                 /tf/dut/imgif0/reg_fv1
add_wave                 /tf/dut/imgif0/reg_packing_mode
add_wave -radix hex      /tf/dut/imgif0/pixel_index

add_wave                 /tf/dut/imgif0/fifo_wren
add_wave -radix hex      /tf/dut/imgif0/fifo_din
add_wave                 /tf/dut/imgif0/fifo_reset

add_wave                 /tf/dut/imgif0/enable_pix
add_wave                 /tf/dut/imgif0/enable_mig
add_wave                 /tf/dut/imgif0/enable_mig_reg
add_wave                 /tf/dut/imgif0/ready_mig
add_wave                 /tf/dut/imgif0/ready_mig_reg

add_wave                 /tf/dut/imgif0/regm_fv
add_wave                 /tf/dut/imgif0/regm_fv1

add_wave -radix hex      /tf/dut/imgif0/cmd_start_address

add_wave -radix unsigned /tf/dut/imgif0/state
add_wave -radix unsigned /tf/dut/imgif0/pixbuf_state

# COORDINATOR ###############################################

add_wave_divider "coord0_ext"
add_wave                 /tf/dut/coord0/clk
add_wave                 /tf/dut/coord0/rst

add_wave -radix hex      /tf/dut/coord0/missed_count
add_wave -radix hex      /tf/dut/coord0/img_size

add_wave                 /tf/dut/coord0/imgif_trig
add_wave                 /tf/dut/coord0/imgctl_framedone
add_wave                 /tf/dut/coord0/imgctl_framewritten
add_wave -radix hex      /tf/dut/coord0/input_buffer_addr
add_wave                 /tf/dut/coord0/output_buffer_trig
add_wave                 /tf/dut/coord0/output_buffer_start
add_wave                 /tf/dut/coord0/output_buffer_done
add_wave                 /tf/dut/coord0/output_buffer_behind
add_wave -radix hex      /tf/dut/coord0/output_buffer_addr

add_wave_divider "coord0_int"
add_wave -radix hex      /tf/dut/coord0/reset_cnt
add_wave                 /tf/dut/coord0/buff_fifo_rd
add_wave                 /tf/dut/coord0/buff_fifo_wr
add_wave -radix hex      /tf/dut/coord0/buff_addr_fifo_count
add_wave                 /tf/dut/coord0/buff_addr_fifo_full
add_wave                 /tf/dut/coord0/buff_addr_fifo_empty
add_wave                 /tf/dut/coord0/buff_addr_prog_full
add_wave                 /tf/dut/coord0/buff_addr_prog_empty

add_wave -radix hex      /tf/dut/coord0/input_buffer_addr_next
add_wave -radix hex      /tf/dut/coord0/output_buffer_addr_next

add_wave -radix hex      /tf/dut/coord0/input_buffer_state
add_wave -radix hex      /tf/dut/coord0/output_buffer_state

# DRAM ######################################################
add_wave_divider "memif_ext"
add_wave                 /tf/dut/memif_clk
#add_wave                /tf/dut/memif_rst
#add_wave                /tf/dut/memif_clk_ref
#add_wave                /tf/dut/memif_mem_refclk
#add_wave                /tf/dut/memif_freq_refclk
#add_wave                /tf/dut/memif_sync_pulse
#add_wave                /tf/dut/memif_rst_phaser_ref
add_wave                 /tf/dut/pll_lock
add_wave                 /tf/dut/memif_ref_dll_lock
add_wave                 /tf/dut/memif_calib_done

add_wave                  /tf/dut/ddr3_dq
add_wave                  /tf/dut/ddr3_addr
add_wave -radix hex      /tf/dut/ddr3_ba
add_wave -radix hex      /tf/dut/ddr3_ck_p
add_wave -radix hex      /tf/dut/ddr3_ck_n
add_wave                 /tf/dut/ddr3_cke
add_wave                 /tf/dut/ddr3_cs_n
add_wave                 /tf/dut/ddr3_cas_n
add_wave                 /tf/dut/ddr3_ras_n
add_wave                 /tf/dut/ddr3_we_n
#add_wave                 /tf/dut/ddr3_odt
add_wave                 /tf/dut/ddr3_dm
add_wave                 /tf/dut/ddr3_dqs_p
#add_wave                 /tf/dut/ddr3_dqs_n
#add_wave                 /tf/dut/ddr3_reset_n


# Memory Arbiter ######################################################
add_wave_divider "memarb0_ext"
add_wave                 /tf/dut/memarb0/clk
add_wave                 /tf/dut/memarb0/reset
add_wave                 /tf/dut/memarb0/calib_done

add_wave                 /tf/dut/memarb0/app_rdy
add_wave                 /tf/dut/memarb0/app_en
add_wave -radix hex      /tf/dut/memarb0/app_cmd
add_wave -radix hex      /tf/dut/memarb0/app_addr

add_wave                 /tf/dut/memarb0/app_wdf_rdy
add_wave                 /tf/dut/memarb0/app_wdf_wren
add_wave                 /tf/dut/memarb0/app_wdf_end
add_wave -radix hex      /tf/dut/memarb0/app_wdf_mask

add_wave                 /tf/dut/memarb0/wdata_rd_en

add_wave -radix hex      /tf/dut/memarb0/wr_fifo_count
add_wave -radix hex      /tf/dut/memarb0/rd_fifo_count

add_wave                 /tf/dut/memarb0/wr_req
add_wave                 /tf/dut/memarb0/wr_ack
add_wave -radix hex      /tf/dut/memarb0/wr_addr
add_wave                 /tf/dut/memarb0/rd_req
add_wave                 /tf/dut/memarb0/rd_ack
add_wave -radix hex      /tf/dut/memarb0/rd_addr

add_wave_divider "memarb0_int"
add_wave -radix hex      /tf/dut/memarb0/state

# Host Interface ######################################################
add_wave_divider "hstif0_ext"
add_wave                 /tf/dut/hstif0/clk
add_wave                 /tf/dut/hstif0/clk_ti
add_wave                 /tf/dut/hstif0/reset_clk

add_wave                 /tf/dut/hstif0/readout_start
add_wave                 /tf/dut/hstif0/readout_done
add_wave -radix hex      /tf/dut/hstif0/readout_addr
add_wave -radix hex      /tf/dut/hstif0/readout_count

add_wave                 /tf/dut/hstif0/mem_rd_req
add_wave -radix hex      /tf/dut/hstif0/mem_rd_addr
add_wave                 /tf/dut/hstif0/mem_rd_ack

add_wave -radix hex      /tf/dut/hstif0/mem_rd_data
add_wave                 /tf/dut/hstif0/mem_rd_data_valid
add_wave                 /tf/dut/hstif0/mem_rd_data_end

add_wave -radix hex      /tf/dut/hstif0/ob_count

add_wave                 /tf/dut/hstif0/ob_rd_en
add_wave -radix hex      /tf/dut/hstif0/pofifo0_rd_count
add_wave -radix hex      /tf/dut/hstif0/pofifo0_dout
#add_wave                 /tf/dut/hstif0/pofifo0_full
#add_wave                 /tf/dut/hstif0/pofifo0_empty

add_wave_divider "hstif0_int"
add_wave                 /tf/dut/hstif0/ob_wr_en
add_wave -radix hex      /tf/dut/hstif0/ob_din
add_wave -radix hex      /tf/dut/hstif0/ob_count

add_wave -radix hex      /tf/dut/hstif0/rd_byte_cnt
add_wave                 /tf/dut/hstif0/fifo_reset

add_wave -radix unsigned /tf/dut/hstif0/po_state

# Pipe Out ###########################################################
add_wave_divider "po0_ext"
add_wave                /tf/dut/po0/ep_read
#add_wave -radix hex     /tf/dut/po0/ep_addr
add_wave -radix hex     /tf/dut/po0/ep_datain

run 250 us
