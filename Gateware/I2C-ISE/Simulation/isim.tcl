onerror {resume}

divider add "Toplevel"
wave add                    /tf/clk
wave add                    /tf/reset
wave add                    /tf/start
wave add                    /tf/done
wave add -radix unsigned    /tf/divclk
wave add                    /tf/memclk
wave add                    /tf/memstart
wave add                    /tf/memwrite
wave add                    /tf/memread
wave add -radix hex         /tf/memdin
wave add -radix hex         /tf/memdout
wave add                    /tf/i2c_sdat
wave add                    /tf/i2c_sdat_out
wave add                    /tf/i2c_drive
wave add                    /tf/i2c_sclk


divider add "I2C Controller"
wave add            /tf/go

divider add "Clock"
wave add -radix hex /tf/dut/divcount
wave add            /tf/dut/divenable
wave add -radix hex /tf/dut/phase

divider add "Memory"
wave add -radix hex /tf/dut/cmem_addr
wave add -radix hex /tf/dut/cmem_dout
wave add            /tf/dut/rmem_write
wave add -radix hex /tf/dut/rmem_addr
wave add -radix hex /tf/dut/rmem_din
wave add -radix hex /tf/dut/mem_addr

divider add "Transmit"
wave add -radix unsigned  /tf/dut/state
wave add -radix hex /tf/dut/tcount
wave add            /tf/dut/twrite
wave add -radix hex /tf/dut/dev_addr
wave add -radix hex /tf/dut/reg_addr

wave add -radix hex /tf/dut/tx_tok;
wave add            /tf/dut/tx_start;
wave add            /tf/dut/tx_done
wave add            /tf/dut/tx_enable
wave add            /tf/dut/tx_rack
wave add            /tf/dut/tx_wack
wave add -radix hex /tf/dut/tx_count
wave add -radix hex /tf/dut/tx_word
wave add -radix hex /tf/dut/tx_shift

divider add "IO"
wave add            /tf/dut/i2c_sclk
wave add            /tf/dut/i2c_sdat_in
wave add            /tf/dut/i2c_sdat_out
wave add            /tf/dut/i2c_drive


divider add "I2C Slave Emulation"
wave add                  /tf/i2c_start
wave add                  /tf/i2c_stop
wave add                  /tf/i2c_dir
wave add -radix unsigned  /tf/i2c_bitcursor
wave add -radix hex       /tf/i2c_wordcap
wave add -radix hex       /tf/i2c_devaddr
wave add                  /tf/i2c_sdout
wave add                  /tf/i2c_writing
wave add -radix hex       /tf/i2c_readmem
wave add -radix hex       /tf/i2c_readout
wave add -radix unsigned  /tf/i2c_readptr
wave add                  /tf/i2c_sclk_setup
wave add                  /tf/i2c_sclk_intent
wave add                  /tf/i2c_clk_stretch
wave add                  /tf/i2c_clk_stretch_count
 
run 1500us;
